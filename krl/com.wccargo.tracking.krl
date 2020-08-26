ruleset com.wccargo.tracking {
  meta {
    use module io.picolabs.wrangler alias wrangler
    use module com.wccargo.html alias html
    shares __testing, orders, index
  }
  global {
    __testing = { "queries":
      [ { "name": "__testing" }
      , { "name": "orders", "args": [ "id" ] }
      ] , "events":
      [ //{ "domain": "d1", "type": "t1" }
      //, { "domain": "d2", "type": "t2", "attrs": [ "a1", "a2" ] }
      ]
    }
    orders = function(id){
      id => wrangler:children(id).head() | wrangler:children().map(function(o){o.get("name")})
    }
    eci_mapper = function(o){
      eci = wrangler:children(o).head(){"eci"}
      href = eci => <</sky/cloud/#{eci}/com.wccargo.order/index.html>> | null
      href => <<<a href="#{href}">#{o}</a> >> | o
    }
    index = function(){
      html:header("World Connections Tracking Information")
      + <<<h1>Tracking Services</h1>
>>
      + orders().sort().map(eci_mapper).join(" ")
      + html:footer()
    }
  }
}
