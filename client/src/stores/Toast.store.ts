import { defineStore } from "pinia"
import { ref, computed } from 'vue'


export type ToastType = 'neutral' | 'error' | 'warning' | 'success'
export interface IToastProps { text: string, duration?: number, type?: ToastType};

export const useToastStore = defineStore('toast', () => {

    const show = ref<boolean>(false)
    const text = ref<string>('')
    const type = ref<ToastType>('neutral')

    const openToast = (props: IToastProps) => {
        $reset()
        text.value = props.text;
        if(props.type) type.value = props.type
        var duration : number = Math.min(Number(props.duration) * 1000 || 5000, 10000) //max duration of 10 seconds
        
        show.value = true;
        setTimeout(() => {
            show.value=false
        }, duration);
    }

    function $reset() {
        show.value = false;
        text.value = ''
        type.value = 'neutral'
    }

    return {show, text, type, openToast}
})

