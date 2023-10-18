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
    var countRes = await mdb.hasMovie(tmdb_id).catch( error => {
        console.log(error);
        res.status(500).json({'message': 'Unable to insert movie'});
    });
    console.log(countRes[0].count);
    if(countRes[0].count > 0){
        res.status(400).json({'message': `TMDB id ${tmdb_id} is already in database`})
        return
    }

    //get movie details from TMDB
    var movie_details = await tmdb.movieGet(tmdb_id).catch( error => {
        console.log(error);
        res.status(500).json({'message': 'Unable to fetch movie details from TMDB'});
        return
    })
    console.log(movie_details.data);

    res.status(200).json({'message': 'good'});
}

// const testFunction = async (req,res) => {
//     console.log('test function!')
//     console.log(req)
//     // tmdb.movieSearch('full metal jacket');
//     // tmdb.movieGet(985);
//     res.status(200).json({      
//         message:"Found",
//         })
// }


// const testPost = async (req,res) => {
//     if(!req.body.text){
//         res.status(400).json({'message': 'missing text'});
//         return
//     }
//     db.testInsert(req.body.text).then((entry) => {
//         res.status(200).json({'data': entry});
//     })
    
// }


module.exports = {movieInsert}