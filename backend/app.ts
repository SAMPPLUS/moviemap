
import express, { Express, Request, Response, Router } from 'express';
import 'dotenv/config'
import morgan from 'morgan';
import bodyParser from 'body-parser';
import cookieParser from 'cookie-parser';

import cron from './scheduled/cron';
import movieGeoRouter from './routes/moviegeo.routes';
import TmdbRouter from './routes/tmdb.routes';
import admin, { type ServiceAccount } from 'firebase-admin';
import {serviceAccount} from './admin-keys/movie-map-firebase-admin'

import { createClient } from './util/supabase';
import { SupabaseClient } from '@supabase/supabase-js';


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

// Create a single supabase client for interacting with your database
const supabaseUrl = 'https://lvaxlehekdolcbrvugzq.supabase.co'
const supabaseKey = String(process.env.SUPABASE_KEY)
//const supabase = createClient(supabaseUrl, supabaseKey)

// Initialize the express engine
const app = express();
app.use(morgan('dev'));
app.use(express.json());

app.use(bodyParser.urlencoded({
    extended: true
  }));
app.use(cookieParser())

const router = Router();

router.use((req: Request, res: Response, next) => {
  console.log('hellooooo ^_^')
  const supabase : SupabaseClient= createClient({req, res})
  res.locals.supabase = supabase;
  console.log(supabase)
  next()
})


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