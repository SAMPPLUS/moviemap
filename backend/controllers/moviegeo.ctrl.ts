import { Request, Response } from 'express';
import moviegeoDb from '../db/moviegeo.db';
import tmdbUtil from '../util/tmdb.util';
import { ValueRequest } from '../interfaces/request.intrf';
import { locationReq, updlocationReq } from '../interfaces/requests';
const img_url = "https://image.tmdb.org/t/p/original"


const movies = async (req: Request, res: Response) => {
    moviegeoDb.getMovies().then((data) => {
        res.status(200).json(data)
    }).catch((error: Error) => {
        console.log(error)
        res.status(500).json({message: 'Unable to fetch movies'})
    })
}

const addMovie = async (req : Request, res : Response) => {
    if(typeof req.query.tmdb_id != 'string'){
        res.status(401).json({message: 'missing tmdb_id'})
        return
    }
    var tmdb_id : string = req.query['tmdb_id']

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
    
    await moviegeoDb.insertMovie(insData).catch( (error:Error) => {
        if(!res.headersSent) {
            res.status(500).json({'message': 'Unable to insert film'});
        }
    });
    if(!res.headersSent) {
        res.status(200).json({'message': 'good'});
    }
}

const imgPath : string = "/api/images/"
const addLocation = async (req : ValueRequest<locationReq>, res : Response) => {
    if(!req.value){ 
        res.status(500).json({message: 'error validating request'});
        return
    }    
    var insertResult = await moviegeoDb.insertLocation(req.value.location, req.value.images).catch((error : Error) =>{
        console.log(error)
        res.status(500).json({message: 'Unable to insert location'})
    });

    if(!insertResult || insertResult.length != 1 || !('id' in insertResult[0])){
        res.status(500).json({message: 'Location Insert Error'})
    }
    res.status(200).json({'message': 'added successfully'})
}

const updateLocation = async(req: ValueRequest<updlocationReq>, res : Response) => {
    if(!req.value){
        res.status(500).json({message: 'error validating request'})
        return 
    }
    var updateResult = await moviegeoDb.updateLocation(req.value.location, req.value.images).then((result: any) => {
        res.status(200).json({message: 'updated successfully'})
    })
    .catch((error:Error) => {
        console.log(error)
        res.status(500).json({'message': 'unable to update location'})
    })
}

const movieGet= async (req : Request , res : Response) => {
    if(typeof req.query.id != 'string'){
        res.status(401).json({message: 'missing id'})
        
        return
    }
    var id : string = String(req.query.id);
    await moviegeoDb.getMovieById(id).then((result: any) => {
        if(result.length == 0) res.status(404).json({'message': 'this movie does not exist'});
        else res.status(200).json(result);

    }).catch( (error:Error) => {
        console.log(error);
        if(!res.headersSent) {
            res.status(500).json({'message': 'Unable to get'});
        }
    });
}

const movieGetTMDB = async (req : Request, res : Response) => {
    if(typeof req.query.tmdb_id != 'string'){
        res.status(401).json({message: 'missing tmdb_id'})
        return
    }
    var tmdb_id : string = String(req.query.tmdb_id);
    await moviegeoDb.getMovieByTMDBId(tmdb_id).then((result : any) => {
        res.status(200).json(result);
    }).catch( (error : Error) => {
        res.status(500).json({'message': 'Unable to get'});
    })
}

const movieLocationsGet = async (req : Request, res : Response) => {
    if(typeof req.query.movie_id != 'string'){
        res.status(401).json({message: 'missing movie_id'});
        return
    }
    var movie_id : string = req.query.movie_id;
    await moviegeoDb.getMovieLocations(movie_id).then((result : any) => {
        var id_keyed_obj : {[propName: number]: any}= {}
        result.forEach((res: {id: number, [propName: string]: any}) => {
            id_keyed_obj[res.id as number] = res
        });
        res.status(200).json(id_keyed_obj);
    }).catch( (error : Error) => {
        console.log(error);
        res.status(500).json({message: 'Unable to get'});
    })
}

const locationImagesGet = async (req : Request, res: Response) => {
    if(Number.isNaN(req.query.location_id)){
        res.status(401).json({message: 'missing or invalid location_id'})
        return
    }
    let location_id = Number(req.query.location_id)
    moviegeoDb.getLocationImages(location_id).then((ret) => {
        res.status(200).json(ret)
    }).catch((error: Error) => {
        res.status(500).json({message: 'could not fetch images'})
    })
}

const imgUpload = async (req: Request, res : Response) => {
    if(!req.file) {
        res.status(401).json({message: 'missing file'});
        return
    }
    await moviegeoDb.insertImage(req.file.filename).then((data) => {
        console.log(data);
        res.status(200).json(data[0])
    }).catch ((error : Error) => {
        console.log(error);
        res.status(500).json({message: 'Unable to insert image'});
    })
}

const locationsRandom = async (req : Request, res: Response) => {
    var count : number = 0;
    if((!req.params.count)){
        count = 5;
    }
    count = Number(req.params.count);
    count = Math.min(count, 30);

    moviegeoDb.getRandomLocations(count).then((data) => {
        res.status(200).json(data)
    }).catch((e: Error)=> {
        res.status(500).json({message: 'unable to fetch locations'})
    })

}


export default {
    movies,
    addMovie,
    addLocation,
    updateLocation,
    movieGet,
    movieGetTMDB,
    movieLocationsGet,
    locationImagesGet,
    imgUpload,
    locationsRandom
  }