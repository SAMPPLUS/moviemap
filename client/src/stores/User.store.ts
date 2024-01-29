import { defineStore } from "pinia"
import {ref, computed} from 'vue'

import { supabase } from '@/main'
import {type User} from '@supabase/supabase-js'

export const useUserStore = defineStore('auth', () => {
    const user = ref<User|null>(null)

    const getUser = async () => {
        var new_user : User|null = null
        if(!user.value){
            var  {data, error} = await supabase.auth.getUser()
            console.log(data)
            if(error){
                console.log(error)
            }
            if(data.user){
                new_user = data.user
            }
        }
        user.value = new_user
        return user.value
    }

    const signOut = async () => {
        await supabase.auth.signOut()
        getUser()
    }

    return {user, getUser, signOut}
})