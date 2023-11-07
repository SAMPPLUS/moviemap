import {createRouter, createWebHistory, createWebHashHistory} from 'vue-router'
import App from '@/App.vue'
import MovieContentVue from '@/components/Sidebar/MovieContent/MovieContent.vue'
import EditLocationsVue from '@/components/Sidebar/MovieContent/EditLocations/EditLocations.vue'
import MovieDetailsVue from '@/components/Sidebar/MovieContent/MovieDetails/MovieDetails.vue'
const routes = [
    {
        path: '/',
        component: MovieContentVue
    },
    {
        path: '/movie/:id(\\d+)',
        component: MovieContentVue,
        children: [
            {
              // UserProfile will be rendered inside User's <router-view>
              // when /user/:id/profile is matched
              path: 'edit',
              component: EditLocationsVue,
            },
            {
                path: 'info',
                component: MovieDetailsVue
            }
        ]
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