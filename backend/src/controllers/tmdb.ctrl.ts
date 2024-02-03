import { Request, Response } from "express";
import tmdbUtil from "../util/tmdb.util";

const movieDetails = async( req: Request, res: Response ) => {
    var movie_id = req.query.movie_id;
    if(typeof movie_id != 'string'){
        res.status(400).json({'message': 'missing movie_id'})
        return
    }
    console.log(req.query);
    await tmdbUtil.movieGet(movie_id, (req.query?.credits == 'true')).then((tmdb_res) => {
        res.status(200).json(tmdb_res.data);
    })
    .catch((error : Error) => {
        console.log(error)
        res.status(500).json({'message': 'Unable to retrieve results from TMDB'});
    })
}

const fetchImage = async( req: Request, res: Response) => {
    //
}

export default {
    movieDetails
}