import sql  from './db'
import { Row } from 'postgres';

const deleteUnlinkedImages = async () : Promise<Row[]> => {
    return sql`delete from locationimages
     where (location_id IS NULL) AND (created_at < CURRENT_TIMESTAMP - INTERVAL '2 day')
     returning file_name`
}

export default {
    deleteUnlinkedImages
}