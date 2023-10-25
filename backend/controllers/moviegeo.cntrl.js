const tmdb = require('../util/tmdb.util')
const mdb = require('../db/moviegeo.db')



const movieInsert = async (req, res) => {
    console.log('here')
    var tmdb_id = req.query.tmdb_id;
    if(!req.query.tmdb_id) {
        res.status(400).json({'message': 'missing tmdb_id'});
        return
    }

    //make sure movie is not already stored in db
    // var checkExisting = mdb.hasMovie(tmdb_id).then((countRes => {
    //     if(countRes[0].count > 0){
    //         res.status(400).json({'message': `TMDB id ${tmdb_id} is already in database`})
    //     }
    // })).catch( error => {
    //     console.log(error);
    //     res.status(500).json({'message': 'Unable to insert movie'});
    // });

    //get movie details from TMDB
    var movie_details = await tmdb.movieGet(tmdb_id).catch( error => {
        console.log(error);
        res.status(500).json({'message': 'Unable to fetch movie details from TMDB'});
        return
    });

    //await checkExisting;

    

    movie_details = movie_details.data;
    var insData = [
            movie_details.id,
            movie_details.title,
            movie_details.release_date
    ];


    await mdb.insertMovie(...insData).catch( error => {
        //console.log(error);
        res.status(500).json({'message': 'Unable to insert film'});
    });
    if(!res.headersSent) {
        res.status(200).json({'message': 'good'});
    }
}

const addLocation = async (req, res) =>{
    var insData = [];
    if(!req.data.movie_id){
        res.status(400).json({'message': 'missing movie_id'});
    }
}


module.exports = {movieInsert}