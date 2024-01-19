import { defineStore } from "pinia"
import { ref, computed } from 'vue'
import { extend } from "@vue/shared";

const component = extend({});

type VueComponent = InstanceType<typeof component>;
export interface IModalProps {
    component: null | VueComponent;
    props?: object;
  }
  

export const useModalStore = defineStore('modal', () => {
    const component = ref<VueComponent>(null)
    const props = ref<any>({})

    const openModal = (payload : IModalProps) => {
        const { props : prop, component : comp } = payload;

        props.value = prop || {}
        component.value = comp
    }
    
    const closeModal = () => {
        $reset()
    }

    function $reset() {
        component.value = null
        props.value = {}
    }

    return {component, props, openModal, closeModal, $reset}
})
