import joi from 'joi'


export const mGetSchema = joi.object({
    query: joi.object({
        id: joi.number().required()
    }).required(),
}).unknown(true).meta({ className: 'movieGetReq' });

export const mTmdbSchema = joi.object({
    query: joi.object({
        tmdb_id: joi.number().required()
    }).required()
}).unknown(true).meta({ className: 'TmdbReq'})

export const lInsertSchema = joi.object({
    body: joi.object({
        location: joi.object({
            movie_id: joi.number().required(),
            title: joi.string().required(),
            description: joi.string().required(),
            lat: joi.number().min(-90).max(90).required(),
            lng: joi.number().min(-180).max(180).required()
        }),
        images: joi.array().items(joi.object({
            id: joi.number().required(),
            type: joi.number().valid(1,2).required(),
            main: joi.bool().default(false),
            description: joi.string().required(),
        }))
    }).required()

    
}).unknown(true).meta({className: 'locationReq'})

