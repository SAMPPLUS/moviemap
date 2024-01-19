import joi from 'joi'


export const lInsertSchema = joi.object({
    location: joi.object({
        movie_id: joi.number().required(),
        title: joi.string().required(),
        scene_desc: joi.string().required(),
        location_desc: joi.string().required(),
        position: joi.object({
            lat: joi.number().min(-90).max(90).required(),
            lng: joi.number().min(-180).max(180).required()
        }).required(),
        g_streetview_embed_url: joi.string()
    }).required(),
    images: joi.array().items(joi.object({
        id: joi.number().required(),
        type: joi.number().valid(1,2).required(),
        main: joi.bool().default(false),
        description: joi.string().required(),
    })).required()
    
}).unknown(true).meta({className: 'locationReq'})

export const lUpdateSchema = joi.object({
    location: joi.object({
        id: joi.number().required(),
        title: joi.string(),
        scene_desc: joi.string(),
        location_desc: joi.string(),
        position: joi.object({
            lat: joi.number().min(-90).max(90).required(),
            lng: joi.number().min(-180).max(180).required()
        }),
        g_streetview_embed_url: joi.string()
    }).required(),
    images: joi.array().items(joi.object({
        id: joi.number().required(),
        type: joi.number().valid(1,2),
        main: joi.bool().default(false),
        description: joi.string(),
        status: joi.string().valid('update','new').required()
    })).required()
    
}).unknown(true).meta({className: 'updlocationReq'})