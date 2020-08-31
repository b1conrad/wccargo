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
      size = event.attr("size")
    }
    send_directive("ack_file_changed",{"id":name,"size":size})
  }
}
