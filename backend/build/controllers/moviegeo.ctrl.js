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
const tmdb = require('../util/tmdb.util');
const mdb = require('../db/moviegeo.db');
const movieInsert = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    console.log(req.query);
    var tmdb_id = req.query.tmdb_id;
    console.log(tmdb_id);
    res.status(200).json({ 'message': 'good' });
    var movie_details = yield tmdb.movieGet(tmdb_id).catch((error) => {
        console.log(error);
        res.status(500).json({ 'message': 'Unable to fetch movie details from TMDB' });
        return;
    });
    movie_details = movie_details.data;
    var insData = {
        tmdb_id: movie_details.id,
        title: movie_details.title,
        release_date: movie_details.release_date
    };
    yield mdb.insertMovie(2).catch((error) => {
        //console.log(error);
        if (!res.headersSent) {
            res.status(500).json({ 'message': 'Unable to insert film' });
        }
    });
    if (!res.headersSent) {
        res.status(200).json({ 'message': 'good' });
    }
});
const movieGet = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    var id = req.query.id;
    yield mdb.getMovieById(id).then((result) => {
        console.log(result);
        res.status(200).json(result);
    }).catch((error) => {
        console.log(error);
        if (!res.headersSent) {
            res.status(500).json({ 'message': 'Unable to get' });
        }
    });
});
module.exports = { movieInsert, movieGet };
