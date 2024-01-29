import axios, {type InternalAxiosRequestConfig} from "axios";
import { getCurrentUser } from 'vuefire'
import {useUserStore} from '@/stores/User.store'

//const userStore = useUserStore()
const moviegeo_axios =  axios.create(
    { withCredentials: true
    }
)
// moviegeo_axios.interceptors.request.use(async (cfg: InternalAxiosRequestConfig) => {
//     const user = await getCurrentUser()
//     if(user){
//         var auth_token = await user.getIdToken()
//         if(auth_token) {
//             cfg.headers.Authorization = auth_token;
//         }
//     }  
//     return cfg
// })

export default moviegeo_axios
