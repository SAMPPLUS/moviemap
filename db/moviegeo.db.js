const sql =require('./db');         

const getMovieById = async (id) => {
    return sql`
        select *
        from movies
        where id=${ id }`;
    return res;
}

const getMovieByTMDBId = async (tmdb_id) => {
    return sql`
        select *
        from movies
        where id=${ tmdb_id }`;
    
}

const hasMovie = async (tmdb_id) => {
    return sql`
        select COUNT(*)
        from movies
        where tmdb_id=${ tmdb_id }`
}


module.exports = {getMovieById, getMovieByTMDBId, hasMovie}