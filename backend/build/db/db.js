"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
//console.log("db_pw: " , process.env.DB_PW)
var postgres = require('postgres');
const sql = postgres('http://127.0.0.1:5432/moviemap', {
    username: process.env.DB_USR,
    password: process.env.DB_PW
});
console.log(sql);
module.exports = sql;
