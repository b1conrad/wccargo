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
      [ //{ "domain": "d1", "type": "t1" }
      //, { "domain": "d2", "type": "t2", "attrs": [ "a1", "a2" ] }
      ]
    }
    index = function(id){
      order:index(wrangler:name() || id)
    }
  }
}
