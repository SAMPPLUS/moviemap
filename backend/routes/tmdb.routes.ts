import express from 'express';
import tmdbCtrl from '../controllers/tmdb.ctrl';

var TmdbRouter = express.Router()

TmdbRouter.use('/mdetails', tmdbCtrl.movieDetails)

export default TmdbRouter