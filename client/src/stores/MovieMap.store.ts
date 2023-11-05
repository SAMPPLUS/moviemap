import { defineStore } from "pinia"
import { ref, computed } from 'vue'
import axios from "axios"


export const useMovieMapStore = defineStore('moviemap', () => {
    //STATE
    const num = ref<number>(73)
    const filmDetails = ref();

    type location = {lat: number, lng: number, id: number, title: string, movie_id: string}
    const locations = ref<location[]>([])
    const selectedLocationIdx = ref<number | undefined>(undefined)

    type modeOption = "movie" | "edit";
    const mode = ref<modeOption>("movie")
    
    //GETTERS

    const releaseYear =  computed<string>(() => filmDetails.value?.release_date ? filmDetails.value.release_date.substring(0,4) : "")

    const movieLocationMisatch = computed<boolean>(() => {
        if(!filmDetails.value || (locations.value?.length)) return false
        if(filmDetails.value.id != locations.value[0].movie_id) return true
        return false
    })

    //ACTIONS
    const fetchMovieDetails = async (id: string) => {
        axios.get('/api/moviegeo/mget', {
            params: {
                id: id
            }
        }).then((film) => {
            filmDetails.value= film.data[0]
        })
        await axios.get('/api/moviegeo/mlocget', {
            params: {
                movie_id: id
            }
        }).then((l) => {
            locations.value = l.data
            selectedLocationIdx.value=undefined
        })
    }

    const setMode = async (newMode: modeOption) => {
        mode.value = newMode
    }

    const setSelectedLocationIdx = (idx: number) => {
        selectedLocationIdx.value = idx
    }

    return {num, filmDetails, locations, selectedLocationIdx, mode, releaseYear, movieLocationMisatch, fetchMovieDetails, setMode, setSelectedLocationIdx}
})