console.log("db_pw: " , process.env.DB_PW)

var postgres = require('postgres')
const sql = postgres('http://127.0.0.1:5432/moviemap', {
    username: 'sampeterson',
    password: process.env.DB_PW
})

module.exports = sql