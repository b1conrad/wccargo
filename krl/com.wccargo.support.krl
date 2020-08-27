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
      + <<<h1>#{title}</h1>
>>
      + "Coming soon!"
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
  rule create_order_pico {
    select when support new_order id re#^(\d{6})$# setting(id)
    fired {
      raise wrangler event "new_child_request" attributes {
        "name":id, "rids":"com.wccargo.order"
      }
    }
  }
}
