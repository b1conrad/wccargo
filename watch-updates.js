// send event to pico-engine

const http = require('http')
const path = '/sky/event/FRKATSa18bCYH6TR8Gj4Cy/watch/'
const options = {
  hostname: 'localhost',
  port: 8080,
  path: '',
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'Content-Length': 0
  }
}
const wr_response = function(res) {
  console.log('statusCode: '+res.statusCode)
  res.on('data',function(d) {
    process.stdout.write(`${d}\n`)
  })
}
const watch_report = function(event,data) {
  var wr_options = options
  var post_data = JSON.stringify(data)
  wr_options.path = path + event
  wr_options.headers['Content-Length'] = post_data.length
  var req = http.request(wr_options,wr_response)
  req.on('error',function(error){
    console.error(error)
  })
  req.write(post_data)
  req.end()
}

// watch for changes 

hound = require('hound')
data = 'C:/Users/admin/AppData/Roaming/npm/node_modules/pico-engine/public/data'

updates = hound.watch(data)

updates.on('create',function(file,stats){
  console.log(file + ' was created')
})
updates.on('change',function(file,stats){
  console.log(file + ' was changed')
  console.log(JSON.stringify(stats,null,2))
  var wr_stats = {
    'name': file,
    'size': stats.size
  }
  watch_report('internal/file_changed',wr_stats)
})
updates.on('delete',function(file){
  console.log(file + ' was deleted')
})

watch_report('internal/watch_started',{'when':'now'})

