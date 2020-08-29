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
})
updates.on('delete',function(file){
  console.log(file + ' was deleted')
})
