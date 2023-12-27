import { defineStore } from "pinia"
import { ref, computed } from 'vue'
import axios from "axios"
import L from "leaflet"
import {type imageObject } from "@/interfaces/edit.int"
import { useMovieMapStore } from "./MovieMap.store"
import { type apiStatus } from "@/types/types"
import {type locFormData} from "@/types/moviegeo.types"
export const useEditLocationStore = defineStore('editlocations', () => {

    const MMStore = useMovieMapStore();

    //STATE

    const mode = ref<'new'|'edit'>('new')

    const saveStatus = ref<apiStatus>('unattempted')

    const modifyingLocation = ref<locFormData>({ position: new L.LatLng(44.45,-20.56), title: '', description: '' })

    
    const sceneImages = ref<imageObject[]>([])
    const locationImages = ref<imageObject[]>([])

    const imgCounter = ref<number>(0)

    //GETTER
    const wrappedNewLocation = computed<L.LatLng>(() => modifyingLocation.value.position.wrap())

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
      modifyingLocation.value.movie_id = MMStore.filmDetails.id as string

      var locData  = modifyingLocation.value as Required<locFormData>
      
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

    return {mode, saveStatus, modifyingLocation, sceneImages, locationImages, wrappedNewLocation, appendImageField, postNewLocation, setMainImage}
})