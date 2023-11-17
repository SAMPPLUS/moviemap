import sql  from './db'

`select * from locationimages where (location_id IS NULL) AND (created_at < CURRENT_TIMESTAMP - INTERVAL '1 day')`