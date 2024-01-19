<script setup lang="ts">
    import { useModalStore } from '@/stores/Modal.store';
    import { ref, watch } from 'vue';
    import PictureModal from '../Modal/inner/PictureModal.vue';
    import { IMG_PATH } from '@/util/const';
    const modal = useModalStore();
    const props  = defineProps({
        src: String,
        caption: String,
        expandable: Boolean,
        external: Boolean
        })
        console.log(props)

    const src = ref<string | undefined>(props.external ? props.src : IMG_PATH + props.src)

    watch(props, async (oldProps, newProps) => {
        src.value = (props.external ? props.src : IMG_PATH + props.src)
    })
    const openImageModal = () => {
        if(!src || !props.expandable) return
        modal.openModal({component: PictureModal, props: { src : src.value, caption: props.caption}})
    }

    const imageLoadError = () => {
        console.log("image load error!")
    }

    

</script>

<template>
    <img v-if="props.src" :src="src" :class="{ expandable : props.expandable}" @click="openImageModal" @error="imageLoadError"/>
</template>

<style scoped>
.expandable {
    cursor: pointer;
}
</style>