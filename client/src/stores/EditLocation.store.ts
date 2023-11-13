import { defineStore } from "pinia"
import { ref, computed } from 'vue'
import axios from "axios"
import L from "leaflet"
import {type imageObject } from "@/interfaces/edit.int"

export const useEditLocationStore = defineStore('editlocations', () => {
    //STATE
    const newLocation = ref<{position : L.LatLng, title: string, description: string}>({ position: new L.LatLng(47.457809,-1.571045), title: '', description: '' })

    
    const images = ref<imageObject[]>([])

    //GETTER
    const wrappedNewLocation = computed<L.LatLng>(() => newLocation.value.position.wrap())

    //ACTION

    const appendImageField = () => {
      var newImage : imageObject = {description: '', type: '1'}
      images.value.push(newImage);
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
            images: images.value
          
        })
        .then((ret) => {
          console.log(ret)
        })
      }

    return {newLocation, images, wrappedNewLocation, appendImageField, uploadImage, postNewLocation}
})