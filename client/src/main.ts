import './assets/sass/style.scss'
import './assets/main.css'

import router from './routes/index'

import { createApp } from 'vue'
import { createPinia } from 'pinia'


import App from './App.vue'

const pinia = createPinia()



const app = createApp(App)
app.config.globalProperties.foo = 'bar';

app.use(pinia)
app.use(router)
app.mount('#app')