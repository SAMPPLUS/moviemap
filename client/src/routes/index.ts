import {createRouter, createWebHistory, createWebHashHistory} from 'vue-router'
import App from '@/App.vue'
import MovieContentVue from '@/components/Sidebar/MovieContent/MovieContent.vue'
import { type RouteRecordRaw } from 'vue-router'

const MovieDetails = () => import('@/components/Sidebar/MovieContent/MovieDetails/MovieDetails.vue')
const EditLocations = () => import('@/components/Sidebar/MovieContent/EditLocations/EditLocations.vue')
const LocationDetails = () => import('@/components/Sidebar/MovieContent/MovieDetails/LocationDetails.vue')

const routes : RouteRecordRaw[]= [
    {
        path: '/',
        redirect: {name: 'movieInfo', params: { movie_id: '19' }}
    },
    {
        path: '/movie/:movie_id(\\d+)',
        component: MovieContentVue,
        name: 'movie',
        children: [
            {
                path: 'info',
                name: 'movieInfo',
                components: {
                    mainMovieContent: MovieDetails
                }
            },
            {
                path: 'edit',
                name: 'movieEdit',
                components:{
                    mainMovieContent: EditLocations
                } 
            },
            {
                path: 'loc/:loc_id(\\d+)',
                name: 'movieLocation',
                components: {
                    mainMovieContent: LocationDetails
                } 
            }
        ],
        redirect: {name: 'movieInfo'}
    }
]

const router = createRouter({
    history: createWebHistory(),
    routes
})

export default router