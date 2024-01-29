import './assets/sass/style.scss'
import './assets/main.css'

import router from './routes/index'

import { createApp } from 'vue'
import { createPinia } from 'pinia'

import { initializeApp } from 'firebase/app'
import { getFirestore, collection } from 'firebase/firestore'
import { VueFire, VueFireAuth,} from 'vuefire'

import { createClient, type AuthChangeEvent, type Session } from '@supabase/supabase-js'

import App from './App.vue'

const pinia = createPinia()

const firebaseConfig = {
  apiKey: "AIzaSyDaMe1Y1DsDnMd8qRvno3M7ixcqhfpRjVk",
  authDomain: "movie-map-85c8a.firebaseapp.com",
  projectId: "movie-map-85c8a",
  storageBucket: "movie-map-85c8a.appspot.com",
  messagingSenderId: "5439597566",
  appId: "1:5439597566:web:76168f9dc72bd088332eaf"
};

// Create a single supabase client for interacting with your database
const supabaseUrl = 'https://lvaxlehekdolcbrvugzq.supabase.co'
const supabaseKey = String(import.meta.env.VITE_SUPABASE_KEY)
export const supabase = createClient(supabaseUrl, supabaseKey)

supabase.auth.onAuthStateChange((event : AuthChangeEvent, session : Session|null) => {
  if (event === 'SIGNED_OUT') {
    // delete cookies on sign out
    const expires = new Date(0).toUTCString()
    document.cookie = `my-access-token=; path=/; expires=${expires}; SameSite=Lax; secure`
    document.cookie = `my-refresh-token=; path=/; expires=${expires}; SameSite=Lax; secure`
  } else if (event === 'SIGNED_IN' || event === 'TOKEN_REFRESHED') {
    if(!session) return
    const maxAge = 100 * 365 * 24 * 60 * 60 // 100 years, never expires
    document.cookie = `my-access-token=${session.access_token}; path=/; max-age=${maxAge}; SameSite=Lax; secure`
    document.cookie = `my-refresh-token=${session.refresh_token}; path=/; max-age=${maxAge}; SameSite=Lax; secure`
  }
})

export const firebaseApp = initializeApp(firebaseConfig)

const db = getFirestore(firebaseApp)

const app = createApp(App)
app.use(VueFire, {
  // imported above but could also just be created here
  firebaseApp,
  modules: [
    // we will see other modules later on
    VueFireAuth(),
  ],
})


app.use(pinia)



app.use(router)
app.mount('#app')