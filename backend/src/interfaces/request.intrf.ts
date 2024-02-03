import { Query } from 'express-serve-static-core';

export interface TypedRequestQuery<T extends Query> extends Express.Request {
    query: T
}

export interface TypedRequestBody<T> extends Express.Request {
    body: T
}

export interface TypedRequest<T extends Query, U> extends Express.Request {
    query: T,
    body: U
}

export interface ValueRequest<T> extends Express.Request {
    value?: T
}