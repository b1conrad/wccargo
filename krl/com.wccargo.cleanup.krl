ruleset com.wccargo.cleanup {
  meta {
    use module io.picolabs.wrangler alias wrangler
    shares __testing, index
  }
  global {
    __testing = { "queries":
      [ { "name": "__testing" }
      ] , "events":
      [ { "domain": "cleanup", "type": "one_cleanup_needed", "attrs": [ "id" ] }
      , { "domain": "cleanup", "type": "cleanup_needed" }
      , { "domain": "cleanup", "type": "reset_neede" }
      ]
    }
    orders = function(id){
      id => wrangler:children(id).head() | wrangler:children().map(function(o){o.get("name")})
    }
    order_rid = "com.wccargo.order"
  }
  rule clean_up_one_order {
    select when cleanup one_cleanup_needed id re#^(\d{6})$# setting(id)
    pre {
      o = orders(id)
      eci = o.get("eci")
      size = wrangler:skyQuery(eci,order_rid,"status").length()
    }
    if size==0 then send_directive("delete",{"Order#":id})
  }
  rule reset_entity_variable {
    select when cleanup reset_neede
    fired {
      clear ent:deletions
    }
  }
  rule clean_up_empty_orders {
    select when cleanup cleanup_needed
    foreach orders() setting(orderno,ordinal)
    pre {
      o = orders(orderno)
      eci = o.get("eci")
      size = eci => wrangler:skyQuery(eci,order_rid,"status").length() | null
      progress = {"id":orderno,"size":size}
    }
    if progress.klog("progress").get("size")==0 then noop()
    fired {
      ent:deletions := ent:deletions.defaultsTo([]).append(orderno)
      raise wrangler event "child_deletion" attributes {"id":o.get("id")}
    }
    finally {
      raise cleanup event "report" on final
    }
  }
  rule report_deletion_list {
    select when cleanup report
    send_directive("deleted",{"orders":ent:deletions.join(",")})
  }
}
