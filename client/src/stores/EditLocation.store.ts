import { defineStore } from "pinia"
import { ref, computed } from 'vue'
import axios from "axios"
import L from "leaflet"
import {type imageObject } from "@/interfaces/edit.int"
import { useMovieMapStore } from "./MovieMap.store"
import { type apiStatus } from "@/types/types"
import {type locFormData, type Location} from "@/types/moviegeo.types"
export const useEditLocationStore = defineStore('editlocations', () => {

    const MMStore = useMovieMapStore();

    //STATE

    const mode = ref<'new'|'edit'>('new')

    const saveStatus = ref<apiStatus>('unattempted')
    const waiting = ref<boolean>(true)
    const locOriginalVals = ref<Location>()
    const modifyingLocation = ref<locFormData>({ position: new L.LatLng(44.45,-20.56), title: '', scene_desc: '', location_desc:'' })

    
    const sceneImages = ref<imageObject[]>([])
    const locationImages = ref<imageObject[]>([])

    const imgCounter = ref<number>(0)

    //GETTER
    const wrappedNewLocation = computed<L.LatLng>(() => modifyingLocation.value.position.wrap())

    //ACTION

    const hasChanged = (attr: string) : boolean => {
      if((!modifyingLocation.value.hasOwnProperty(attr)) || (!locOriginalVals.value) ||(!locOriginalVals.value.hasOwnProperty(attr))) return false

      return locOriginalVals.value[attr as keyof Location] != modifyingLocation.value[attr as keyof locFormData]

    }

    const appendImageField = (type: 1 | 2, main: boolean = false) => {
      var newImage : imageObject = {key: imgCounter.value, description: '', type: type, main: main, status: 'new'}
      if(type==1){
        sceneImages.value.push(newImage);
      }
      else{
        locationImages.value.push(newImage);
      }
      imgCounter.value +=1
      return newImage
    }

    const postUpdateLocation = async () => {
      if(!MMStore.filmDetails) return;
      var locData = modifyingLocation.value
      console.log(sceneImages.value.filter((img) => Boolean(img.id)).concat(locationImages.value.filter((img) => Boolean(img.id))))

      return axios.post('/api/moviegeo/lupdate', {
        location: locData,
        images: sceneImages.value.filter((img) => Boolean(img.id)).concat(locationImages.value.filter((img) => Boolean(img.id)))
      })
    
    }

    const postNewLocation = async () => {
      if(!MMStore.filmDetails) return;
      modifyingLocation.value.movie_id = MMStore.filmDetails.id as string

      var locData  = modifyingLocation.value as Required<locFormData>
      return axios.post('/api/moviegeo/linsert', {
          location: locData,
          images: sceneImages.value.concat(locationImages.value)   
      })
      
  }

    const setMainImage = async(event: Event, type : 1|2, imgObject: imageObject) => {
      var imageGroup
      if(type==1) imageGroup = sceneImages 
      else imageGroup = locationImages

      imageGroup.value.forEach((image : imageObject, idx : number) => {
        image.main = false
      });
      imgObject.main = true

    }

    return {mode, saveStatus, waiting, locOriginalVals, modifyingLocation, sceneImages, locationImages, wrappedNewLocation, appendImageField, postNewLocation, postUpdateLocation, setMainImage}
})