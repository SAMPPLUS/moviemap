import { defineStore } from "pinia"
import { ref, computed } from 'vue'
import axios from "axios"


export const useEditLocationStore = defineStore('editlocations', () => {
    //STATE
    const selectedLocation = ref<{position : L.LatLngLiteral}>({ position: { lng: -1.571045 as number, lat: 47.457809 as number } })


    //ACTION
    const postNewLocation = async(imageFile : File) => {
 
    
        let data = new FormData();
        let fd = new FormData();
        fd.append('image', imageFile)
        await axios.post('/api/moviegeo/imgupload', fd).then((r) => {
          console.log(r)
        })
      }

    return {selectedLocation, postNewLocation}
})