
import sql from './db'

const getMovieById = async (id : string) => {
    return sql`
        select *
        from movies
        where id=${ id }`;
}

const getMovieByTMDBId = async (tmdb_id : string) => {
    return sql`
        select *
        from movies
        where tmdb_id=${ tmdb_id }`;
    
}

const hasMovie = async (tmdb_id : string) => {
    return sql`
        select COUNT(*)
        from movies
        where tmdb_id=${ tmdb_id }`
}

interface movieInsValues { tmdb_id: string; title: string; release_date: string}
const insertMovie = async (vals : movieInsValues) => {
    return sql`
        insert into movies
        ${sql(vals)}
        returning *`
}

interface locValues { movie_id: string; title: string; lat: string; long: string;};
const insertLocation = async (vals : locValues) => {
    var ins : object = {
        movie_id: vals.movie_id,
        title: vals.title,
        geo: `POINT(${vals.long} ${vals.lat})`
    };
    
    console.log(ins);

    return sql`
        insert into locations
        ${sql(ins)}
        returning *`
}

const getMovieLocations = async (movie_id : string ) => {
    return sql`
    select * from locations
    where movie_id=${sql(movie_id)}
    `
}


export default {
    getMovieById,
    getMovieByTMDBId,
    hasMovie,
    insertMovie,
    insertLocation,
    getMovieLocations
}