"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const zod_1 = require("zod");
const mInsertSchema = zod_1.z.object({
    query: zod_1.z.object({
        tmdb_id: zod_1.z.string({
            required_error: 'tmdb_id is required'
        })
    }),
});
module.exports = { mInsertSchema };
