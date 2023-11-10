import { defineStore } from "pinia"
import { ref, computed } from 'vue'
import axios from "axios"
import L from "leaflet"
import {type imageObject } from "@/interfaces/edit.int"

export const useEditLocationStore = defineStore('editlocations', () => {
    //STATE
    const newLocation = ref<{position : L.LatLng}>({ position: new L.LatLng(47.457809,-1.571045) })

    
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

    const postNewLocation = async(imageFile : File, movie_id: string, data: object) => {
 
        let fd = new FormData();
        fd.append('image', imageFile)
        for (const [key, value] of Object.entries(data)) {
          fd.append(key,value)
        }
        for (const [key, value]of Object.entries(newLocation.value.position)) {
          fd.append(key,value.toString())
        }
        fd.append('movie_id', movie_id)
        await axios.post('/api/moviegeo/linsert', fd).then((r) => {
          console.log(r)
        })
      }

    return {newLocation, images, wrappedNewLocation, appendImageField, uploadImage, postNewLocation}
})