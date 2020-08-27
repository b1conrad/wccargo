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
  }
  rule allocate_channel {
    select when wrangler ruleset_added where event:attr("rids") >< meta:rid
    if ent:status.isnull() then noop()
    fired {
      ent:status := <<No information available at this time.>>
      raise order event "new_status_check"
    }
  }
  rule check_for_updated_status {
    select when order new_status_check
    pre {
      url = <<#{meta:host}/data/#{wrangler:name()}.txt>>
    }
    fired {
      raise order event "new_status" attributes {"url":url}
    }
  }
  rule update_status {
    select when order new_status
      url re#^(.+)$# setting(url)
    pre {
      status = http:get(url){"content"}
        .klog("status")
    }
    send_directive("status",{"url":url,"status":status})
    fired {
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
