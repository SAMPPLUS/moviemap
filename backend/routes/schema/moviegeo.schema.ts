import { z } from "zod";

const mInsertSchema = z.object({
    query: z.object({
        tmdb_id: z.string({
            required_error: 'tmdb_id is required'
        })
    }),
});

export default {
    mInsertSchema
}