
import express, { Express, Request, Response, Router } from 'express';
import 'dotenv/config'
import morgan from 'morgan';
import bodyParser from 'body-parser';

import { testAlert } from './scheduled/cron';
import movieGeoRouter from './routes/moviegeo.routes';
import TmdbRouter from './routes/tmdb.routes';

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

//testAlert.start();
 
// Handling '/' Request
app.get('/', (req : Request, res: Response) => {
    res.send("TypeScript With Express");
});
 
// Server setup
app.listen(port, () => {
    console.log(`TypeScript with Express 
         http://localhost:${port}/`);
});