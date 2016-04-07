var express = require('express');
const exec = require('child_process').exec;
var router = express.Router();
var debug = true;
/* GET users listing. */
router.all('/prometheus', function(req, res, next) {
  if (process.env.SNMP_SERVER) {
    snmp_server = process.env.SNMP_SERVER;
  }else{
    snmp_server = '127.0.0.1';
  }
  var aggregate = [];
  console.log(req.body);
  message = req.body;
  var service = message.commonLabels.service;
  var check = message.commonLabels.alertname;
  for (var a in message.alerts) {
    alarm = message.alerts[a];
    try {
      comment = JSON.parse(alarm.annotations.description);
      aggregate.push(comment);
      console.log( "comment:" + JSON.stringify(comment));
    }catch(err){
      console.log("comment json parse error:" + alarm.annotations.description);
    }
    if(debug){
      console.log( "status:" + alarm.status);
    }
  }
  var state = 'OK';
  console.log(JSON.stringify(aggregate));
  if (message.status == 'firing') {
    state = 'CRITICAL';
  }else{
    state = 'OK';
  }
  args = ['/usr/bin/node_snmptrap', snmp_server, service, state, check, JSON.stringify(aggregate)];
  cmd = args.join(' ');
  console.log('inject command:' + cmd);
  const child = exec(cmd, (error, stdout, stderr) => {
    if (error) {
      throw error;
    }
    //console.log(req.body);
    console.log(stdout);
  });
  res.send({});
});

module.exports = router;
