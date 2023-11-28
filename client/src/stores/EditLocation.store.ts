import { defineStore } from "pinia"
import { ref, computed } from 'vue'
import axios from "axios"
import L from "leaflet"
import {type imageObject } from "@/interfaces/edit.int"
import { useMovieMapStore } from "./MovieMap.store"
import { type apiStatus } from "@/types/types"
export const useEditLocationStore = defineStore('editlocations', () => {

    const MMStore = useMovieMapStore();

    //STATE

    const saveStatus = ref<apiStatus>('unattempted')

    interface locFormData  {position : L.LatLng; title: string; description: string; movie_id?: string}
    const newLocation = ref<locFormData>({ position: new L.LatLng(47.457809,-1.571045), title: '', description: '' })

    
    const sceneImages = ref<imageObject[]>([])
    const locationImages = ref<imageObject[]>([])

    const imgCounter = ref<number>(0)

    //GETTER
    const wrappedNewLocation = computed<L.LatLng>(() => newLocation.value.position.wrap())

    //ACTION

    const appendImageField = (type: 1 | 2, main: boolean = false) => {
      var newImage : imageObject = {key: imgCounter.value, description: '', type: type, main: main}
      if(type==1){
        sceneImages.value.push(newImage);
      }
      else{
        locationImages.value.push(newImage);
      }
      imgCounter.value +=1
      return newImage
    }


    const postNewLocation = async () => {
      if(!MMStore.filmDetails) return;
      newLocation.value.movie_id = MMStore.filmDetails.id as string

      var locData  = newLocation.value as Required<locFormData>
      
      await axios.post('/api/moviegeo/linsert', {
          location: locData,
          images: sceneImages.value.concat(locationImages.value)   
      })
      .then((ret) => {
        console.log(ret)
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

    return {saveStatus, newLocation, sceneImages, locationImages, wrappedNewLocation, appendImageField, postNewLocation, setMainImage}
})