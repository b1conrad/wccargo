ruleset com.wccargo.order.ui {
  meta {
    use module com.wccargo.html alias html
    shares __testing, index
    provides index
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
    details = function(id){
      id
    }
    index = function(id){
      html:header("World Connections Tracking Information")
      + <<
            
            <h1>Tracking Services for order #{id}</h1>
            
           
            <p>
World Connections offers tracking services for all your shipments. Coming Soon!<p>
          

        >>
      + html:footer()
    }
  }
}
