ruleset com.wccargo.internal {
  meta {
    use module io.picolabs.wrangler alias wrangler
    shares __testing
  }
  global {
    __testing = { "queries":
      [ { "name": "__testing" }
      //, { "name": "entry", "args": [ "key" ] }
      ] , "events":
      [ //{ "domain": "d1", "type": "t1" }
      //, { "domain": "d2", "type": "t2", "attrs": [ "a1", "a2" ] }
      ]
    }
    orders = function(id){
      id => wrangler:children(id).head() | wrangler:children().map(function(o){o.get("name")})
    }
  }
  rule handle_file_changed {
    select when internal file_changed name re#public/data.(\d{6})[.]txt$# setting(name)
    pre {
      size = event:attr("size")
    }
    send_directive("ack_file_changed",{"id":name,"size":size})
    fired {
      raise internal event "check_order_status" attributes {"id":name,"size":size}
    }
  }
  rule check_for_order_pico {
    select when internal check_order_status id re#^(\d{6})$# setting(id)
    pre {
      order_pico = orders(id).klog("order_pico")
      order_pico_eci = order_pico.get("eci")
      size = event:attr("size")
    }
    if order_pico_eci then
      event:send({
        "eci":order_pico_eci,"domain":"order","type":"new_status_check",
        "attrs": {"size":size}
      })
    fired {
      // order pico already exists
    } else {
      // have support ruleset create it
      raise support event "create_order_pico" attributes {"id":id, "size":size}
    }
  }
}
