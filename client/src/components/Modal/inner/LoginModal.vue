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
    //var ui = new firebaseui.auth.AuthUI(firebase.auth());


    const auth = useFirebaseAuth()!

    function signinPopup() {
        //error.value = null
        signInWithPopup(auth, googleAuthProvider).catch((reason) => {
            console.error('Failed sign', reason)
            //error.value = reason
        })
    }
</script>

<template>
    <div>
        <button @click="signinPopup">click</button>
    </div>
</template>

<style></style>