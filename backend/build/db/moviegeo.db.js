"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
const sql = require('./db');
const getMovieById = (id) => __awaiter(void 0, void 0, void 0, function* () {
    return sql `
        select *
        from movies
        where id=${id}`;
});
const getMovieByTMDBId = (tmdb_id) => __awaiter(void 0, void 0, void 0, function* () {
    return sql `
        select *
        from movies
        where id=${tmdb_id}`;
});
const hasMovie = (tmdb_id) => __awaiter(void 0, void 0, void 0, function* () {
    return sql `
        select COUNT(*)
        from movies
        where tmdb_id=${tmdb_id}`;
});
const insertMovie = (vals) => __awaiter(void 0, void 0, void 0, function* () {
    console.log("vals: " + vals);
    return sql `
        insert into movies
        ${sql(vals)}
        returning *`;
});

const insertLocation = (vals) => __awaiter(void 0, void 0, void 0, function* () {
    var ins = {
        movie_id: vals.movie_id,
        title: vals.title,
        release_date: vals.release_date,
        geo: `'POINT(${vals.lat} ${vals.long})'`
    };
    return sql `
        insert into locations
        ${sql(ins)}
        returning *`;
});
module.exports = { getMovieById, getMovieByTMDBId, hasMovie, insertMovie, insertLocation };
