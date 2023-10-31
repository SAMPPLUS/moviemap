import { defineStore } from "pinia"
import { ref } from 'vue'
import axios from "axios"


export const useMovieMapStore = defineStore('moviemap', () => {
    const API_URL = "http://localhost:3001"

    const num = ref(73)

    const getMovieDetails = async () => {
        return axios.get('/api/tmdb/mdetails', {
            params: {
                movie_id: "985"
            }
        })
    }

    

    return {num, getMovieDetails}
})