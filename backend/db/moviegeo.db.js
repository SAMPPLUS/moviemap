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

const insertMovie = async (tmdb_id,title,release_date) => {
    return sql`
        insert into movies
        ${sql({ tmdb_id: tmdb_id, title: title, release_date: release_date})}`
    
}

const insertLocation = async (movie_id, title, description, lat, long) => {
    const geo = `'POINT(${lat} ${long})'`;
    return sql`
        insert into locations
        ${sql({movie_id: movie_id, title: title, description: description, geo: geo})}`
}


module.exports = {getMovieById, getMovieByTMDBId, hasMovie, insertMovie, insertLocation}