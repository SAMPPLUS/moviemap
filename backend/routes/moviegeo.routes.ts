import express from 'express';
import moviegeoCtrl from '../controllers/moviegeo.ctrl';
import validate from './validate';
import moviegeoSchema from './schema/moviegeo.schema';
var movieGeoRouter = express.Router();

movieGeoRouter.post('/minsert', validate(moviegeoSchema.mInsertSchema),  moviegeoCtrl.addMovie);

movieGeoRouter.get('/mget', moviegeoCtrl.movieGet);

movieGeoRouter.get('/mgettmdb', moviegeoCtrl.movieGetTMDB);

movieGeoRouter.post('/linsert', moviegeoCtrl.addLocation);

movieGeoRouter.get('/mlocget', moviegeoCtrl.movieLocationsGet);


export default movieGeoRouter