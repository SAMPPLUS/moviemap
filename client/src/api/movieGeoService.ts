import { useMovieMapStore } from "@/stores/MovieMap.store"
import moviegeo_axios from "./movieGeoAxios"



const fetchMovie = async (id: string) => {
    var movieMapStore = useMovieMapStore()
    movieMapStore.movieFetchingStatus= 'inprogress'
    await moviegeo_axios.get('/api/moviegeo/mget', {
        params: {
            id: id
        }
    }).then((film) => {
        console.log(film)
        movieMapStore.filmDetails = film.data[0]
        movieMapStore.movieFetchingStatus = 'success'

    }).catch((error : Error) => {
        console.log(error)
        movieMapStore.movieFetchingStatus = 'failed'
        return [error]
    })
}

const fetchLocations = async(movie_id: string) => {
    var movieMapStore = useMovieMapStore()
    movieMapStore.locFetchingStatus = 'inprogress'
    await moviegeo_axios.get('/api/moviegeo/mlocget', {
        params: {
            movie_id: movie_id
        }
    }).then((l) => {
        movieMapStore.locations = l.data
        movieMapStore.locFetchingStatus = 'success'

    }).catch((error) => {
        movieMapStore.locFetchingStatus = 'failed'
        return [error]
    })
}

const fetchMovieList = async () => {
    return moviegeo_axios.get('/api/moviegeo/movies')
}

const fetchLocationImages = async(location_id: number) => {
    return moviegeo_axios.get('/api/moviegeo/limgget', {
        params: {
            location_id: location_id
        }
    })
}


export default {fetchMovie, fetchLocations, fetchMovieList, fetchLocationImages}