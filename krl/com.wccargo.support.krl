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
      [ //{ "domain": "d1", "type": "t1" }
      //, { "domain": "d2", "type": "t2", "attrs": [ "a1", "a2" ] }
      ]
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
}
