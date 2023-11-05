import { defineStore } from "pinia"
import { ref, computed } from 'vue'


export const useEditLocationStore = defineStore('editlocations', () => {
    //STATE
    const selectedLocation = ref<{position : L.LatLngLiteral}>({ position: { lng: -1.571045 as number, lat: 47.457809 as number } })

    return {selectedLocation}
})