import axios, {type InternalAxiosRequestConfig} from "axios";
import { useAuthStore } from "@/stores/Auth.store"
import { getCurrentUser } from 'vuefire'

const moviegeo_axios =  axios.create()
moviegeo_axios.interceptors.request.use(async (cfg: InternalAxiosRequestConfig) => {
    console.log("req interceptor")
    const auth_store = useAuthStore()
    const user = await getCurrentUser()
    if(user){
        var auth_token = await user.getIdToken()
        if(auth_token) {
            cfg.headers.Authorization = auth_token;
        }
    }  
    return cfg
})

export default moviegeo_axios
