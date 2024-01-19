
import express, { Express, Request, Response, Router } from 'express';
import 'dotenv/config'
import morgan from 'morgan';
import bodyParser from 'body-parser';

import cron from './scheduled/cron';
import movieGeoRouter from './routes/moviegeo.routes';
import TmdbRouter from './routes/tmdb.routes';
import admin, { type ServiceAccount } from 'firebase-admin';
import {serviceAccount} from './admin-keys/movie-map-firebase-admin'
import { DecodedIdToken } from 'firebase-admin/lib/auth/token-verifier';

declare global {
  namespace Express {
      interface Request {
          value?: any | undefined;
      }
  }
}
export {}

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount as ServiceAccount)
})

// Initialize the express engine
const app = express();
app.use(morgan('dev'));
app.use(express.json());

app.use(bodyParser.urlencoded({
    extended: true
  }));

const router = Router();


router.use('/moviegeo', movieGeoRouter);
router.use('/tmdb', TmdbRouter);
 
app.use('/api/', router);

app.use('/api/',express.static('public'))
const port = process.env.PORT;


//cron jobs
//testAlert.start();
cron.cleanImagesTask.start();
 
// Handling '/' Request
app.get('/', (req : Request, res: Response) => {
    res.send("TypeScript With Express");
});
 
// Server setup
app.listen(port, () => {
    console.log(`Listening on 
         http://localhost:${port}/`);
});