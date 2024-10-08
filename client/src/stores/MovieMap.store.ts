import { defineStore } from "pinia"
import { ref, computed } from 'vue'
import placeholder from "@/assets/placeholder-still.jpeg"
import { useRouter } from 'vue-router';
import { type Location, type Locations } from "@/types/moviegeo.types";
import { type apiStatus } from "@/types/types"

export type FilmDetails = {id: string; [propName: string]: any;}


export const useMovieMapStore = defineStore('moviemap', () => {

    const router = useRouter()

    //STATE

    const movieFetchingStatus = ref<apiStatus>('unattempted')
    const locFetchingStatus = ref<apiStatus>('unattempted')

    const filmDetails = ref<FilmDetails>()

    const locations = ref<Locations>({})
    
    const selectedLocationIdx = ref<number | undefined>(undefined)

    const hoveredLocation = ref<number | undefined>(undefined)

    type ModeOption = "home" | "movie" | "loc" | "edit";
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

    const unsetSelected = () => {
        
    }

    return {locFetchingStatus, movieFetchingStatus, filmDetails, locations, selectedLocationIdx, hoveredLocation, mode, placeholderStill, releaseYear, movieLocationMisatch, selectedLocation,  setMode, setSelectedLocationId}
})