import { defineStore } from "pinia"
import {ref, computed} from 'vue'

import { supabase } from '@/main'
import {type User} from '@supabase/supabase-js'

export const useUserStore = defineStore('auth', () => {
    const user = ref<User|null>(null)
    const loading = ref<boolean>(false)
    const error = ref<string | null>(null)

    const getUser = async () => {
        
        loading.value = true;
        error.value = null;

        try {
            if (!user.value) {
                const { data, error: fetchError } = await supabase.auth.getUser();

                if (fetchError) {
                    error.value = `Error retrieving user: ${fetchError.message}`;
                    console.log(error.value);
                    return null;
                }

                user.value = data.user;
            }

        } catch (err) {
            error.value = `Unexpected error: ${err}`;
            console.log(error.value);

        } finally {
            loading.value = false;
        }

        return user.value;
    }

    const signOut = async () => {
        try {
            const { error } = await supabase.auth.signOut();
            
            if (error) {
                console.log('Error signing out:', error);
                return;
            }
    
            user.value = null;
    
        } catch (err) {
            console.log('Unexpected error during sign out:', err);
        }
    }

    return {user, loading, error, getUser, signOut}
})