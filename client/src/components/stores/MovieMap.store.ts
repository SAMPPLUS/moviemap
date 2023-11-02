import { defineStore } from "pinia"
import { ref, computed } from 'vue'
import axios from "axios"


export const useMovieMapStore = defineStore('moviemap', () => {
    const API_URL : string = "http://localhost:3001"
    //STATE
    const num = ref<number>(73)
    const selectedFilm = ref();
    //GETTERS
    const poster_path = computed<string>(() =>
     selectedFilm.value?.poster_path ?
     ('https://image.tmdb.org/t/p/original' + selectedFilm.value.poster_path) : "")

    const director = computed<string>(() => selectedFilm.value?.credits ? selectedFilm.value.credits.crew.filter(({job} : {job: string}) => job ==='Director')[0]?.name : '')

    const release_year =  computed<string>(() => selectedFilm.value?.release_date ? selectedFilm.value.release_date.substring(0,4) : "")

    //ACTIONS
    const fetchMovieDetails = async () => {
        var film = await axios.get('/api/tmdb/mdetails', {
            params: {
                movie_id: "12493",
                credits: true
            }
        }) 
        selectedFilm.value = film.data;
        
    }


    

    return {num, selectedFilm, poster_path, release_year, director, fetchMovieDetails}
})