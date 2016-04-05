var express = require('express');
var router = express.Router();

/* GET users listing. */
router.all('/prometheus', function(req, res, next) {
  console.log(req.body);
  res.send({});
});

module.exports = router;
