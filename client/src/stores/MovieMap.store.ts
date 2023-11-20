import { defineStore } from "pinia"
import { ref, computed } from 'vue'
import axios from "axios"
import placeholder from "../../public/images/placeholder-still.jpeg"
import { useRouter } from 'vue-router';
import { type apiStatus } from "@/types/types"



export const useMovieMapStore = defineStore('moviemap', () => {

    const router = useRouter()

    //STATE

    const movieFetchingStatus = ref<apiStatus>('unattempted')
    const locFetchingStatus = ref<apiStatus>('unattempted')

    type FilmDetails = {id: string; [propName: string]: any;}
    const filmDetails = ref<FilmDetails>()

    type Location = {lat: number, lng: number, id: string, title: string, movie_id: string, main_img_path: string, description: string}
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

    const selectedLocation = computed<Location|null>(() => {
        if((selectedLocationIdx.value == undefined) || (!locations.value)) return null
        return locations.value[selectedLocationIdx.value]
    })

    //ACTIONS
    

    const setMode = async (newMode: ModeOption) => {
        mode.value = newMode
    }

    const setSelectedLocationIdx = (idx: number) => {
        selectedLocationIdx.value = idx
        if(mode.value == 'movie'){
            router.push({name: 'movieLocation', params: { }})
        }
        else if(mode.value == 'edit') {

        }
    }

    return {locFetchingStatus, movieFetchingStatus, filmDetails, locations, selectedLocationIdx, mode, placeholderStill, releaseYear, movieLocationMisatch, selectedLocation,  setMode, setSelectedLocationIdx}
})