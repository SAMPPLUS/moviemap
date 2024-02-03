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

const movieGet =  async (id : string, crew : boolean = false) => {
    var params : any =  {
        'language': 'en-US',
        'api_key': process.env.TMDB_API_KEY,
    }
    if (crew){
        params.append_to_response = "credits";
    }
    console.log(params)

    return axios.get(API_URL + '/movie/' + id, {
        params: params
    })
}



export default {
    movieSearch,
    movieGet
}