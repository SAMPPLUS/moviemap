const tmdb = require('../util/tmdb.util')

const movieSearch = async (req,res) => {
    var qs = req.query.query;
    var page = req.query.page
    if(!qs){
        res.status(400).json({'message': 'missing query string'});
        return
    }
    if(!page){
        page = 1;
    }


    tmdb.movieSearch(qs, page).then( (tmdb_res) =>{
        res.status(200).json(tmdb_res.data);
    }).catch( error => {
        console.log(error)
        res.status(500).json({'message': 'Unable to retrieve results from TMDB'});
    })
}

const movieGet = async (req,res) => {
    var movie_id = req.query.movie_id;
    if(!movie_id){
        res.status(400).json({'message': 'missing movie id'});
        return
    }

    tmdb.movieGet(movie_id).then( (tmdb_res) => {
        res.status(200).json(tmdb_res.data);
    }).catch( error => {
        console.log(error);
        res.status(500).json({'message': 'Unable to retrieve results from TMDB'});
    })
}



module.exports = {movieSearch, movieGet}