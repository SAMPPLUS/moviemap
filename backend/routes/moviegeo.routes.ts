import express from 'express';
import moviegeoCtrl from '../controllers/moviegeo.ctrl';
//import moviegeoSchema from '../schema/moviegeo.schema';
import  FileMiddleware  from '../middleware/file.middleware';
import multer from 'multer';
import { validate } from '../middleware/validate.middleware';
import * as schema from '../schemas/moviegeo.schema';
import { Request, Response } from 'express';

const upload = multer({ dest: 'public/images/uploads' })

var movieGeoRouter = express.Router();

movieGeoRouter.post('/minsert', moviegeoCtrl.addMovie);

movieGeoRouter.get('/mget', moviegeoCtrl.movieGet);

movieGeoRouter.get('/mgettmdb', moviegeoCtrl.movieGetTMDB);

movieGeoRouter.post('/linsert', validate(schema.lInsertSchema),moviegeoCtrl.addLocation);

movieGeoRouter.post('/lupdate', validate(schema.lUpdateSchema), moviegeoCtrl.updateLocation )

movieGeoRouter.get('/mlocget', moviegeoCtrl.movieLocationsGet)

movieGeoRouter.get('/limgget', moviegeoCtrl.locationImagesGet)

//movieGeoRouter.get('/')

movieGeoRouter.post('/imgupload', FileMiddleware.diskLoader.single('image'), moviegeoCtrl.imgUpload)



export default movieGeoRouter