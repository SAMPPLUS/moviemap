
import sql  from './db'
import { Row } from 'postgres';
import { locationReq } from '../interfaces/requests';

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


type position = {lat: number, lng: number}
interface locValues { movie_id: number; title: string; position: position; description: string; main_img_path?: string, id?: number };
type updLocValues = Omit<locValues, 'movie_id'>
interface imageValues {id: number; description: string; type: number; location_id?: string}
type imageIns =Omit<imageValues, 'id'>
const insertLocation = async (locVals: locValues, imgVals : imageValues[]) => {
    var locIns = {
        movie_id: locVals.movie_id,
        title: locVals.title,
        description: locVals.description,
        geo: `POINT(${locVals.position.lng} ${locVals.position.lat})`
    };
    console.log(locIns)

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


}

const updateLocation = async (locVals: updLocValues) => {
    var id = locVals.id;
    if(!id){
        throw new Error('missing location id, cannot update');
    }
    var locIns = {
        title: locVals.title,
        description: locVals.description,
        geo: `POINT(${locVals.position.lng} ${locVals.position.lat})`
    };

    return sql`
    update locations set
    ${sql(locIns)}
    where locations.id=${id}
    `
}

const updateLocationImage = async (vals: imageValues) => {
    return sql`
    update locationimages set
    ${sql(vals)}
    where 
    `
}


const getMovieLocations = async (movie_id : string ) => {
    return sql`select locations.*, ST_X(geo::geometry) AS lng, ST_Y(geo::geometry) AS lat, li1.file_name scene_img, li1.description scene_img_desc, li2.file_name loc_img, li2.description loc_img_desc from locations 
    left join locationimages as li1 on li1.location_id=locations.id and li1.main=true and li1.type=1
    left join locationimages as li2 on li2.location_id=locations.id and li2.main=true and li2.type=2
    where locations.movie_id=${movie_id}`
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
    updateLocation,
    updateLocationImage,
    getMovieLocations,
    insertImage
}