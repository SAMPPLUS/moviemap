import { defineStore } from "pinia"
import { useCurrentUser } from 'vuefire'
import {ref, computed} from 'vue'

export const useAuthStore = defineStore('auth', () => {
    const user = ref<any>(useCurrentUser())

    const getAuthToken = async () : Promise<string|undefined> => {
        console.log(useCurrentUser().value?.getIdToken())
        return user.value?.getIdToken()
    }

    return {user, getAuthToken}
})