const axios = require('axios').default;
const API_URL : string = "https://api.themoviedb.org/3/";


const movieSearch = async (query_str : string, page : number) => {
    return axios.get(API_URL + '/search/movie', {
        params: {
            'api_key':process.env.TMDB_API_KEY,
            'include_adult': false,
            'language': 'en-US',
            'page': page,
            'query': query_str,
        }
    })
}

const movieGet =  async (id : string) => {
    return axios.get(API_URL + '/movie/' + id, {
        params: {
            'language': 'en-US',
            'api_key':process.env.TMDB_API_KEY
        }
    })
}



export default {
    movieSearch,
    movieGet
}