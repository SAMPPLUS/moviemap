import { defineStore } from "pinia"
import { ref, computed } from 'vue'
import axios from "axios"
import placeholder from "../../public/images/placeholder-still.jpeg"


export const useMovieMapStore = defineStore('moviemap', () => {
    //STATE
    const num = ref<number>(73)

    type FilmDetails = {id: string; [propName: string]: any;}
    const filmDetails = ref<FilmDetails>();

    type Location = {lat: number, lng: number, id: number, title: string, movie_id: string, main_img_path: string, description: string}
    const locations = ref<Location[]>([])
    const selectedLocationIdx = ref<number | undefined>(undefined)

    type ModeOption = "movie" | "edit";
    const mode = ref<ModeOption>("movie")

    const placeholderStill = ref<string>(placeholder)
    
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

    

    const setMode = async (newMode: ModeOption) => {
        mode.value = newMode
    }

    const setSelectedLocationIdx = (idx: number) => {
        selectedLocationIdx.value = idx
    }

    return {num, filmDetails, locations, selectedLocationIdx, mode, placeholderStill, releaseYear, movieLocationMisatch, fetchMovieDetails, setMode, setSelectedLocationIdx}
})