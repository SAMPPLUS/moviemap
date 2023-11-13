
import { PendingQuery, PostgresType } from 'postgres';
import sql  from './db'
import { Row } from 'postgres';

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

interface locValues { movie_id: string; title: string; lat: string; lng: string; description: string; main_img_path?: string };
interface imageValues {id: string; description: string; type: number; file_name: string}
const insertLocation = async (vals : {location: locValues, images: any[]}) => {
    var locIns = {
        movie_id: vals.location.movie_id,
        title: vals.location.title,
        description: vals.location.description,
        geo: `POINT(${vals.location.lng} ${vals.location.lat})`
    };
    var qArr : PendingQuery<Row[]>[] = []

    var location_id = await sql`
    insert into locations
    ${sql(locIns)}
    returning id`

    vals.images.forEach((image: imageValues) => {
        var id: string =  image.id
        var imgIns = {
            description: image.description,
            type : image.type,
            location_id:
        }
        qArr.push(sql`
        update locationimages set
        ${sql(image)}
        where 
        `)
    })


    return sql.begin(async sql => {
        

    })
}


const getMovieLocations = async (movie_id : string ) => {
    return sql`
    select *, ST_X(geo::geometry) AS lng, ST_Y(geo::geometry) AS lat from locations
    where movie_id=${movie_id}
    `
}

const insertImage = async (fileName : string) => {
    return sql`
    insert into locationimages
    (file_name)
    values (${ fileName })
    returning id
    `
}


export default {
    getMovieById,
    getMovieByTMDBId,
    hasMovie,
    insertMovie,
    insertLocation,
    getMovieLocations,
    insertImage
}