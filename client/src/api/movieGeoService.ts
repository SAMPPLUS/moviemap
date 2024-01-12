import axios from "axios"
import { useMovieMapStore } from "@/stores/MovieMap.store"


const fetchMovie = async (id: string) => {
    console.log("fetching " + id)
    var movieMapStore = useMovieMapStore()
    movieMapStore.movieFetchingStatus= 'inprogress'
    await axios.get('/api/moviegeo/mget', {
        params: {
            id: id
        }
    }).then((film) => {
        movieMapStore.filmDetails = film.data[0]
        movieMapStore.movieFetchingStatus = 'success'

    }).catch((error) => {
        movieMapStore.movieFetchingStatus = 'failed'
        return [error]
    })
}

const fetchLocations = async(movie_id: string) => {
    var movieMapStore = useMovieMapStore()
    movieMapStore.locFetchingStatus = 'inprogress'
    await axios.get('/api/moviegeo/mlocget', {
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

const fetchLocationImages = async(location_id: number) => {
    return axios.get('/api/moviegeo/limgget', {
        params: {
            location_id: location_id
        }
    })
}


export default {fetchMovie, fetchLocations, fetchLocationImages}