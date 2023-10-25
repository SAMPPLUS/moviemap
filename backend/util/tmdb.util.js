require('dotenv').config()

const axios = require('axios').default;

const API_URL = "https://api.themoviedb.org/3/";


const movieSearch = async (query_str, page) => {
    return axios.get(API_URL + '/search/movie', {
        params: {
            'api_key':process.env.TMDB_API_KEY,
            'include_adult': false,
            'language': 'en-US',
            'page': page,
            'query': query_str,
            'page': page
        }
    })
}

const movieGet =  async (id) => {
    return axios.get(API_URL + '/movie/' + id, {
        params: {
            'language': 'en-US',
            'api_key':process.env.TMDB_API_KEY
        }
    })
}



module.exports = {movieSearch, movieGet}