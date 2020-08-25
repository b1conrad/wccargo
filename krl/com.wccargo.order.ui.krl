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
      id == "308862" => <<30886200    7/23/20  0  pc(s)    Los Angeles                    USA

 CANCELLED    7/24/20 10:53HRS

>> |
      id == "308865" => <<30886500    8/01/20  2424  pc(s)     CORONA                           USA

 DELIVERED    8/05/20 07:00HRS
  BOOKED      7/31/20 15:28HRS

>> |
      id == "308868" => <<30886800    8/21/20  0 pc(s)    Lagos                           NIGERIA

  BOOKED      8/20/20 12:04HRS

>> |
      <<No information available at this time.>>
    }
    index = function(id){
      html:header("World Connections Tracking Information")
      + <<
            
            <h1>Tracking Services for order #{id}</h1>
            
           
            <pre>#{details(id)}<pre>
          

        >>
      + html:footer()
    }
  }
}
