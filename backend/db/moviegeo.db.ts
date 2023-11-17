
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


type PartialBy<T, K extends keyof T> = Omit<T, K> & Partial<Pick<T, K>>
interface locValues { movie_id: string; title: string; lat: string; lng: string; description: string; main_img_path?: string };

interface imageValues {id: string; description: string; type: number; file_name: string; location_id?: string}
type imageIns =Omit<imageValues, 'id'>
const insertLocation = async (locVals: locValues, imgVals : imageValues[]) => {
    var locIns = {
        movie_id: locVals.movie_id,
        title: locVals.title,
        description: locVals.description,
        geo: `POINT(${locVals.lng} ${locVals.lat})`
    };

    return sql.begin('read write', async sql => {
        const [location] = await sql`
        insert into locations
        ${sql(locIns)}
        returning id`

        var imageQueries : Array<Promise<Row>> = []

        imgVals.forEach((element : imageValues) => {
            
            element['location_id'] = location.id;
            imageQueries.push(sql.savepoint(sql => sql`
            update locationimages set
            ${sql(element as imageIns)}
            where 
            id=${element.id}
            returning id
            `))
        });
        
        await Promise.all(imageQueries).then((rets) => {
            console.log(rets);
        })

        return [location ]
    })

    return sql`
    insert into locations
    ${sql(locIns)}
    returning id`

}

const updateLocationImage = async (vals: imageValues) => {
    return sql`
    update locationimages set
    ${sql(vals)}
    where 
    `
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
    updateLocationImage,
    getMovieLocations,
    insertImage
}