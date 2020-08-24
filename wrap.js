var spawn = require('child_process').spawn
var carrier = require('carrier')
var cmd = spawn('ls',['/Users/bconrad/b1conrad/wccargo'])
var listen = carrier.carry(cmd.stdout)
listen.on('line',function(line){
  console.log('line: '+line)
})

