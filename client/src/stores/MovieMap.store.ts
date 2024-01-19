import { defineStore } from "pinia"
import { ref, computed } from 'vue'
import placeholder from "../../public/images/placeholder-still.jpeg"
import { useRouter } from 'vue-router';
import { type Location } from "@/types/moviegeo.types";
import { type apiStatus } from "@/types/types"



export const useMovieMapStore = defineStore('moviemap', () => {

    const router = useRouter()

    //STATE

    const movieFetchingStatus = ref<apiStatus>('unattempted')
    const locFetchingStatus = ref<apiStatus>('unattempted')

    type FilmDetails = {id: string; [propName: string]: any;}
    const filmDetails = ref<FilmDetails>()

    const locations = ref<{[propName: number]: Location}>({})
    
    const selectedLocationIdx = ref<number | undefined>(undefined)

    type ModeOption = "movie" | "loc" | "edit";
    const mode = ref<ModeOption>("movie")

    const placeholderStill = ref<string>(placeholder)
    
    //GETTERS

    const releaseYear =  computed<string>(() => filmDetails.value?.release_date ? filmDetails.value.release_date.substring(0,4) : "")

    const movieLocationMisatch = computed<boolean>(() => {
        return false
        // if(locFetchingStatus.value != 'success') return false
        // if((!filmDetails.value) || (Object.keys(locations.value).length == 0)) return false
        // if(filmDetails.value.id != locations.value[0].movie_id) return true
        // return false
    })

    const selectedLocation = computed<Location|null>(() => {
        if((selectedLocationIdx.value == undefined) || (!locations.value)) return null
        return locations.value[selectedLocationIdx.value]
    })

    //ACTIONS
    

    const setMode = async (newMode: ModeOption) => {
        mode.value = newMode
    }

    const setSelectedLocationId = (id: number) => {
        selectedLocationIdx.value = id
        switch(mode.value) {
            case 'movie':
                router.push({name: 'movieLocation', params: {loc_id: locations.value[id].id }})
                return
            case 'loc':
                router.replace({name: 'movieLocation', params: {loc_id: locations.value[id].id}})    
                return
            case 'edit':
                return
            default:
                return
        }
    }

    return {locFetchingStatus, movieFetchingStatus, filmDetails, locations, selectedLocationIdx, mode, placeholderStill, releaseYear, movieLocationMisatch, selectedLocation,  setMode, setSelectedLocationId}
})