import { Request, Response } from 'express';
import moviegeoDb from '../db/moviegeo.db';
import tmdbUtil from '../util/tmdb.util';

const img_url = "https://image.tmdb.org/t/p/original"


const addMovie = async (req : Request, res : Response) => {
    var tmdb_id = req.query.tmdb_id;
    if (typeof tmdb_id != 'string') return;

    var movie_details = await tmdbUtil.movieGet(tmdb_id, true).catch( (error : Error) => {
        console.log(error);
        res.status(500).json({'message': 'Unable to fetch movie details from TMDB'});
        return
    });

    movie_details = movie_details.data;
    var insData = {
            tmdb_id: movie_details.id,
            title: movie_details.title,
            release_date: movie_details.release_date,
            overview: movie_details.overview,
            poster_path: img_url + movie_details.poster_path,
            director: movie_details.credits.crew.filter(({job} : {job: string}) => job ==='Director')[0]?.name
    }
    console.log(insData)
    
    await moviegeoDb.insertMovie(insData).catch( (error:Error) => {
        if(!res.headersSent) {
            res.status(500).json({'message': 'Unable to insert film'});
        }
    });
    if(!res.headersSent) {
        res.status(200).json({'message': 'good'});
    }
}

const addLocation = async (req : Request, res : Response) => {
    console.log(req.body);
    await moviegeoDb.insertLocation(req.body).then( (result) => {
        res.status(200).json(result[0]);
    }).catch((error : Error) =>{
        console.log(error)
        res.status(500).json({message: 'Unable to insert location'})
    })
}

const movieGet = async (req : Request, res : Response) => {
    if(typeof req.query.id != 'string'){return}
    var id : string = req.query.id;
    await moviegeoDb.getMovieById(id).then((result: any) => {
        console.log(result);
        res.status(200).json(result);
    }).catch( (error:Error) => {
        console.log(error);
        if(!res.headersSent) {
            res.status(500).json({'message': 'Unable to get'});
        }
    });
}

const movieGetTMDB = async (req : Request, res : Response) => {
    if(typeof req.query.tmdb_id != 'string'){return}
    var tmdb_id : string = req.query.tmdb_id;
    await moviegeoDb.getMovieByTMDBId(tmdb_id).then((result : any) => {
        res.status(200).json(result);
    }).catch( (error : Error) => {
        res.status(500).json({'message': 'Unable to get'});
    })
}

const movieLocationsGet = async (req : Request, res : Response) => {
    if(typeof req.query.movie_id != 'string'){return}
    var movie_id : string = req.query.movie_id;
    await moviegeoDb.getMovieLocations(movie_id).then((result : any) => {
        res.status(200).json(result);
    }).catch( (error : Error) => {
        console.log(error);
        res.status(500).json({message: 'Unable to get'});
    })
}

const imgUpload = async (req: Request, res : Response) => {
    console.log(req);
    res.status(200).json({message: 'success'})
}


export default {
    addMovie,
    addLocation,
    movieGet,
    movieGetTMDB,
    movieLocationsGet,
    imgUpload
  }