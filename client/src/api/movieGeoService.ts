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

const fetchLocations = async(id: string) => {
    var movieMapStore = useMovieMapStore()
    movieMapStore.locFetchingStatus = 'inprogress'
    await axios.get('/api/moviegeo/mlocget', {
        params: {
            movie_id: id
        }
    }).then((l) => {
        movieMapStore.locations = l.data
        movieMapStore.locFetchingStatus = 'success'

    }).catch((error) => {
        movieMapStore.locFetchingStatus = 'failed'
        return [error]
    })
}


export default {fetchMovie, fetchLocations}