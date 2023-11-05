import {createRouter, createWebHistory, createWebHashHistory} from 'vue-router'
import App from '@/App.vue'
import MovieContentVue from '@/components/Sidebar/MovieContent/MovieContent.vue'
import EditLocationsVue from '@/components/Sidebar/EditLocations/EditLocations.vue'
const routes = [
    {
        path: '/',
        component: MovieContentVue
    },
    {
        path: '/movie/:id(\\d+)',
        component: MovieContentVue
    },
    {
        path: '/edit/:id(\\d+)',
        component: EditLocationsVue
    }
]

const router = createRouter({
    history: createWebHistory(),
    routes
})

export default router