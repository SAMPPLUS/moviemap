// /moviegeo
const express = require('express');
var router = express.Router();
const controller = require('../controllers/moviegeo.cntrl')


// router.get('/test', controller.testFunction)

// router.post('/testpost', controller.testPost)

router.get('/minsert', controller.movieInsert);


module.exports = router;
