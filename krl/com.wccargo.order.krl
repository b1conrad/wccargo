ruleset com.wccargo.order {
  meta {
    use module io.picolabs.wrangler alias wrangler
    use module com.wccargo.order.ui alias order
    shares __testing, index
  }
  global {
    __testing = { "queries":
      [ { "name": "__testing" }
      , { "name": "index", "args": [ "id" ] }
      ] , "events":
      [ { "domain": "order", "type": "new_status", "attrs": [ "url" ] }
      , { "domain": "order", "type": "new_status", "attrs": [ "txt" ] }
      , { "domain": "order", "type": "new_status_check" }
      ]
    }
    index = function(id){
      order:index(wrangler:name() || id,ent:status)
    }
    no_information_msg = <<No information available at this time.>>
  }
  rule initialize {
    select when wrangler ruleset_added where event:attr("rids") >< meta:rid
    if ent:status.isnull() then noop()
    fired {
      ent:status := no_information_msg
      raise order event "new_status_check" attributes event:attrs
    }
  }
  rule check_for_updated_status {
    select when order new_status_check
    pre {
      url = <<#{meta:host}/data/#{wrangler:name()}.txt>>
      size = event:attr("size")
      new_status = ent:status == no_information_msg
      larger_status = size.isnull() => false | size > ent:status.length()
    }
    if new_status || larger_status then noop()
    fired {
      raise order event "new_status" attributes {"url":url}
    }
  }
  rule update_status {
    select when order new_status
      url re#^(.+)$# setting(url)
    pre {
      response = http:get(url)
      status = response{"status_code"} == 200 => response{"content"} | response{"status_line"}
    }
    send_directive("status",{"url":url,"status":status})
    fired {
      ent:lastResponse := response
      ent:status := status
    }
  }
  rule update_status_from_txt {
    select when order new_status where event:attr("txt")
    pre {
      status = event:attr("txt")
    }
    send_directive("status",{"status":status})
    fired {
      ent:status := status
    }
  }
}
