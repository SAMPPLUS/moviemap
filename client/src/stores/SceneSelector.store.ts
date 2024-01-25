import { defineStore } from "pinia"
import { ref, computed } from 'vue'

export const useSceneSelectorStore = defineStore('sceneselector', () => {
    const vis = ref<'showing'|'partial'|'hiding'>('hiding')


    return {vis}
})