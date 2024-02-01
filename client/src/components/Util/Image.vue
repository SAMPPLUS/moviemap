<script setup lang="ts">
    import { useModalStore } from '@/stores/Modal.store';
    import { ref, watch } from 'vue';
    import PictureModal from '../Modal/inner/PictureModal.vue';
    import { IMG_PATH } from '@/util/const';
    import pp from '@/assets/poster-placeholder.png'
    const modal = useModalStore();
    const props  = defineProps({
        src: String,
        caption: String,
        expandable: Boolean,
        external: Boolean,
        poster: Boolean
        })

    const src = ref<string | undefined>(props.src)
    if(!props.external){
        src.value = IMG_PATH + props.src
    }

    watch(props, async (oldProps, newProps) => {
        src.value = (props.external ? props.src : IMG_PATH + props.src)
    })

    const openImageModal = () => {
        if((!src.value) || !props.expandable) return
        modal.openModal({component: PictureModal, props: { src : src.value, caption: props.caption}})
    }

    const imageLoadError = (e: Event) => {
        console.log(e)
        console.log("image load error!")
    }

    const imageLoadSuccess = () => {
    }

    const placeholder = ref<string>("")
    if(props.poster){
        placeholder.value = pp
    }


</script>

<template>
    <img v-if="props.src || placeholder" :src="src || placeholder" :class="{ expandable : props.expandable}" @click="openImageModal" @error="imageLoadError" @load="imageLoadSuccess"/>
    <div v-else></div>
</template>

<style scoped>
.expandable {
    cursor: pointer;
}
</style>