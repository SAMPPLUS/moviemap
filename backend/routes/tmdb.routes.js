const express = require('express');
var router = express.Router();
var controller = require('../controllers/tmdb.cntrl')

router.get('/msearch', controller.movieSearch)

router.get('/mget', controller.movieGet);


module.exports = router;