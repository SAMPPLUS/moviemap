import { defineStore } from "pinia"
import { ref, computed } from 'vue'
import axios from "axios"
import L, { imageOverlay } from "leaflet"
import {type imageObject } from "@/interfaces/edit.int"

export const useEditLocationStore = defineStore('editlocations', () => {
    //STATE
    const newLocation = ref<{position : L.LatLng, title: string, description: string}>({ position: new L.LatLng(47.457809,-1.571045), title: '', description: '' })

    
    const sceneImages = ref<imageObject[]>([])
    const locationImages = ref<imageObject[]>([])

    //GETTER
    const wrappedNewLocation = computed<L.LatLng>(() => newLocation.value.position.wrap())

    //ACTION

    const appendImageField = (type: 1 | 2, main: boolean = false) => {
      var newImage : imageObject = {description: '', type: type, main: main}
      if(type==1){
        sceneImages.value.push(newImage);
      }
      else{
        locationImages.value.push(newImage);
      }
      return newImage
    }

    const uploadImage = async(imageFile: File) => {
      let fd = new FormData();
      fd.append('image', imageFile)
      return axios.post('/api/moviegeo/imgupload', fd)
    }

    const postNewLocation = async () => {
        
        await axios.post('/api/moviegeo/linsert', {
          
            location: newLocation.value,
            images: sceneImages.value
          
        })
        .then((ret) => {
          console.log(ret)
        })
      }

    const setMainImage = async(event: Event, type : 1|2, index: number) => {
      var imageGroup
      if(type==1) imageGroup = sceneImages 
      else imageGroup = locationImages
      imageGroup.value.forEach((image : imageObject, idx : number) => {
        image.main = idx == index;
      });

    }

    return {newLocation, sceneImages, locationImages, wrappedNewLocation, appendImageField, uploadImage, postNewLocation, setMainImage}
})