

<script lang="ts">
    import { GoogleAuthProvider } from 'firebase/auth'
    export const googleAuthProvider = new GoogleAuthProvider()
</script>

<script setup lang="ts">

    import { supabase } from '@/main'
    import { ref } from 'vue';
    import { useModalStore } from '@/stores/Modal.store';
    import { useUserStore } from '@/stores/User.store';

    const modal = useModalStore()
    const userStore = useUserStore()

    const email = ref<string>('')
    const pw = ref<string>('')
    const loading = ref<boolean>(false)
    const errorMessage = ref<string | null>(null)
    
    const mode = ref<'register'|'login'>('login')

    if(['register','login'].includes(modal.props.mode)) {
        mode.value = modal.props.mode;
    }


    const signUpNewUser = async () => {
        // Reset error and start loading state
        errorMessage.value = null;
        loading.value = true;



        const { data, error } = await supabase.auth.signUp({
            email: email.value,
            password: pw.value,
            options: {
                emailRedirectTo: 'http://localhost:5173/'
            }
        });

        if (error) {
            errorMessage.value = `Sign-up failed: ${error.message}`;
            console.log(error); 
        } else {
            errorMessage.value = null;
            console.log("User registered successfully!", data);
            modal.closeModal();
        }

        loading.value = false; 
    }

    const signInWithEmail = async () => {
        
        errorMessage.value = null;
        loading.value = true;

        const { data, error } = await supabase.auth.signInWithPassword({
            email: email.value,
            password: pw.value
        });

        if (error) {
            errorMessage.value = `Login failed: ${error.message}`;
            console.log(error);
        } else {
            errorMessage.value = null;
            userStore.getUser(); 
            console.log("User signed in successfully!", data);
            modal.closeModal();
        }

        loading.value = false;
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
                <div id="error-msg">{{ errorMessage }}</div>
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


#error-msg {
    color: red;
    font-size: .7em;
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