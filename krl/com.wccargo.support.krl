ruleset com.wccargo.support {
  meta {
    use module io.picolabs.wrangler alias wrangler
    use module html
    shares __testing, index
  }
  global {
    __testing = { "queries":
      [ { "name": "__testing" }
      //, { "name": "entry", "args": [ "key" ] }
      ] , "events":
      [ { "domain": "support", "type": "new_order", "attrs": [ "id" ] }
      //, { "domain": "d2", "type": "t2", "attrs": [ "a1", "a2" ] }
      ]
    }
    orders = function(id){
      id => wrangler:children(id).head() | wrangler:children().map(function(o){o.get("name")})
    }
    title = "World Connections Customer Service"
    index = function(){
      html:header(title)
      + <<    <h1>#{title}</h1>
      <form action="/sky/event/#{meta:eci}/web/support/new_order" method="post">
        <input name="id" placeholder="Order#"><br>
        <input type="checkbox" name="ready">I have run the DataPerfect report for this order<br>
        <button type="submit">support/new_order</button>
      </form>
>>
      + html:footer()
    }
  }
  rule guard_against_duplicates {
    select when support new_order id re#^(\d{6})$# setting(id)
    if orders(id) then send_directive("already exists")
    fired {
      last
    }
  }
  rule guard_against_missing_data {
    select when support new_order id re#^(\d{6})$#
    pre {
      ready = event:attr("ready")
    }
    if not ready then send_directive("must run DataPerfect report")
    fired {
      last
    }
  }
  rule create_order_pico {
    select when support new_order id re#^(\d{6})$# setting(id)
    fired {
      raise wrangler event "new_child_request" attributes {
        "name":id, "rids":"com.wccargo.order"
      }
      last
    }
  }
  rule catch_all {
    select when support new_order
    send_directive("order # must be six digit number")
  }
}
