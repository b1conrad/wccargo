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
      , { "domain": "support", "type": "orders_to_create", "attrs": [ "url" ] }
      ]
    }
    crlf = (13.chr() + "?" + 10.chr()).as("RegExp")
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
//
// event support:new_order from UI
//
  rule guard_against_duplicates {
    select when support new_order id re#^(\d{6})$# setting(id)
    if orders(id) then send_directive("already exists",{"id":id})
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
      raise support event "new_order_ready" attributes {"id":id}
    }
  }
  rule react_to_invalid_number {
    select when support new_order
    pre {
      valid = event:attr("id").match(re#^\d{6}$#)
    }
    if not valid then
      send_directive("order # must be six digit number",{"id":id})
  }
//
// event support:new_order_ready when we can create the new order pico
//
  rule go_ahead_and_create_order_pico {
    select when support new_order_ready id re#^(\d{6})$# setting(id)
    fired {
      raise wrangler event "new_child_request" attributes {
        "name":id, "rids":"com.wccargo.order"
      }
    }
  }
//
// events support:orders_to_create and order_list_ready for importing
//
  rule import_and_create_order_picos {
    select when support orders_to_create url re#^(http.+)# setting(url)
    pre {
      response = http:get(url)
      orders = response.get("status_code") == 200 => response.get("content") | null
      order_list = orders => orders.split(crlf) | null
    }
    if orders then noop()
    fired {
      raise support event "order_list_ready" attributes {"orders":order_list}
    }
    finally {
      ent:lastResponse := response
    }
  }
  rule check_create_new_order_picos {
    select when support order_list_ready
    foreach event:attrs.get("orders") setting(o,i)
    pre {
      id = o.extract(re#^(\d{6})[.]txt$#).head()
      already_exists = id && orders(id)
    }
    if id && not already_exists then noop()
    fired {
      raise support event "new_order_ready" attributes {"id":id}
    }
  }
}
