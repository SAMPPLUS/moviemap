import {createRouter, createWebHistory, createWebHashHistory} from 'vue-router'
import App from '@/App.vue'
import MovieContentVue from '@/components/Sidebar/MovieContent/MovieContent.vue'
import { type RouteRecordRaw } from 'vue-router'
import {authCheck} from './auth'

const MovieDetails = () => import('@/components/Sidebar/MovieContent/MovieDetails/MovieDetails.vue')
const EditLocations = () => import('@/components/Sidebar/MovieContent/EditLocations/EditLocations.vue')
const LocationDetails = () => import('@/components/Sidebar/MovieContent/MovieDetails/LocationDetails.vue')
const List = () => import('@/components/Sidebar/Explore/List.vue')



const routes : RouteRecordRaw[]= [
    {
        path: '/',
        redirect: {name: 'explore'}
    },
    {
        path: '/explore',
        component: List,
        name: 'explore'
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
                beforeEnter: authCheck,
                children: [
                    {
                        path: '',
                        alias: 'new',
                        name: 'newLocation',
                        components: {
                            mainMovieContent: EditLocations
                        }
                    },
                    {
                        path: ':edit_loc_id(\\d+)',
                        name: 'editLocation',
                        components: {
                            mainMovieContent: EditLocations
                        }
                    }
                ],

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