var express = require('express');
const exec = require('child_process').exec;
var router = express.Router();

/* GET users listing. */
router.all('/prometheus', function(req, res, next) {
  if (process.env.SNMP_SERVER) {
    snmp_server = process.env.SNMP_SERVER;
  }else{
    snmp_server = '127.0.0.1';
  }
  args = ['/usr/bin/node_snmptrap', snmp_server, 'CRITICAL', 'TEST_TRAP', 'hello message'];
  cmd = args.join(' ');
  const child = exec(cmd, (error, stdout, stderr) => {
    if (error) {
      throw error;
    }
    console.log(stdout);
  });
  res.send({});
});

module.exports = router;
