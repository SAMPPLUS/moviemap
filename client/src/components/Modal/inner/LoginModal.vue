<script lang="ts">
    import { GoogleAuthProvider } from 'firebase/auth'
    export const googleAuthProvider = new GoogleAuthProvider()
</script>

<script setup lang="ts">
    import {
    signInWithPopup,
    signOut,
    } from 'firebase/auth'
    import firebaseui from 'firebaseui';
    import { useFirestore, useFirebaseAuth, useCurrentUser } from 'vuefire';
    import { supabase } from '@/main'
    import { ref } from 'vue';
    import { useModalStore } from '@/stores/Modal.store';
    import { useUserStore } from '@/stores/User.store';
    //var ui = new firebaseui.auth.AuthUI(firebase.auth());

    const modal = useModalStore()
    const auth = useFirebaseAuth()!
    const userStore = useUserStore()

    const email = ref<string>('')
    const pw = ref<string>('')
    const mode = ref<'register'|'login'>('login')
    if(['register','login'].includes(modal.props.mode)) {
        mode.value = modal.props.mode;
    }

    function signinPopup() {
        //error.value = null
        signInWithPopup(auth, googleAuthProvider).catch((reason) => {
            console.error('Failed sign', reason)
            //error.value = reason
        })
    }

    const signUpNewUser = async() => {
        const { data, error } = await supabase.auth.signUp({
            email: email.value,
            password: pw.value,
            options: {
            emailRedirectTo: 'http://localhost:5173/'
                }
            })
        console.log(data, error)
    }

    const signInWithEmail = async() =>{
        const { data, error } = await supabase.auth.signInWithPassword({
            email: email.value,
            password: pw.value
        })
        console.log(data, error)
        userStore.getUser()
    }

    function supabaseGoogleSignin() {
        supabase.auth.signInWithOAuth({
            provider: 'google',
        })
    }


</script>

<template>
    <div id="login-modal">
        <div id="login-content">
            <div id="register-user" v-if="mode=='register'">
                <h3>New User</h3>
                <div class="login-forms">
                    <label for="email">email</label>
                    <input name="email" type="email" v-model="email">
                    <label for="pw">password</label>
                    <input name="pw" type="password" v-model="pw">
                </div>
                <div class="login-actions">
                    <button @click="signUpNewUser" :disabled="!(email && pw)">register</button>
                </div>
                <div>
                    <a href="#" @click="mode=(mode=='register' ? 'login' : 'register')">Sign in</a>
                </div>
            </div>
            <div id="login-user" v-else>
                
                <h3>User Sign-in</h3>
                <div class="login-forms">
                    <label for="email">email</label>
                    <input name="email" type="email" v-model="email">
                    <label for="pw">password</label>
                    <input name="pw" type="password" v-model="pw">
                </div>
                
                <div class="login-actions">
                        <button @click="signInWithEmail">Sign in</button>
                </div>
                <div>
                    <a href="#" @click="mode=(mode=='login' ? 'register' : 'login')">Register</a>
                </div>
            </div>
        </div>
        
    </div>
</template>

<style>

#login-modal {
    background: white;
    height: 400px;
    width: 400px;
    padding: 60px;
    color:black;
    font-family: 'cushion';
}

#login-content {
    display: flex;
    flex-direction: column;
    justify-content: center;
}

.login-forms {
    display: flex;
    flex-direction: column;
}

.login-actions {
    display: flex;
    flex-direction: row;
    justify-content: flex-end;
    padding:6px;
}
</style>