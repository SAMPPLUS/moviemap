
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

interface movieInsValues { tmdb_id: string; title: string; release_date: string; overview: string; director: string; poster_path: string;}
const insertMovie = async (vals : movieInsValues) => {
    return sql`
        insert into movies
        ${sql(vals)}
        ON CONFLICT (tmdb_id)
        DO UPDATE SET
        (overview, director, poster_path)=(EXCLUDED.overview, EXCLUDED.director, EXCLUDED.poster_path)
        returning *`
}

interface locValues { movie_id: string; title: string; lat: string; lng: string; description: string; main_img_path: string };
const insertLocation = async (vals : locValues) => {
    var ins : object = {
        movie_id: vals.movie_id,
        title: vals.title,
        description: vals.description,
        main_img_path: vals.main_img_path,
        geo: `POINT(${vals.lng} ${vals.lat})`
    };
    console.log(ins)
    return sql`
        insert into locations
        ${sql(ins)}
        returning *`
}

const getMovieLocations = async (movie_id : string ) => {
    return sql`
    select *, ST_X(geo::geometry) AS lng, ST_Y(geo::geometry) AS lat from locations
    where movie_id=${movie_id}
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