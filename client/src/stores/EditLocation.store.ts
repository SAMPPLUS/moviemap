import { defineStore } from "pinia"
import { ref, computed } from 'vue'
import axios from "axios"


export const useEditLocationStore = defineStore('editlocations', () => {
    //STATE
    const newLocation = ref<{position : L.LatLngLiteral}>({ position: { lng: -1.571045 as number, lat: 47.457809 as number } })


    //ACTION
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

    return {newLocation, postNewLocation}
})