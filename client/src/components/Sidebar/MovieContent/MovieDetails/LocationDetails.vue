<script setup lang="ts">
console.log('running locationDetails setup script')

import { watch, ref } from 'vue';
import { useMovieMapStore } from '@/stores/MovieMap.store'
import type { apiStatus } from '@/types/types';
import { useRoute, useRouter } from 'vue-router';
import { storeToRefs } from 'pinia';
import { IMG_PATH } from "@/util/const";
import GoogleStreetViewEmbed from '../GoogleStreetViewEmbed.vue';
import { useModalStore } from '@/stores/Modal.store';
import PictureModal from '@/components/Modal/inner/PictureModal.vue';
import Image from '@/components/Util/Image.vue';


const router = useRouter()
const route = useRoute()
console.log(route.params)
const movieMapStore = useMovieMapStore()
const {locFetchingStatus} = storeToRefs(movieMapStore)
const awaitingFetch = ref<boolean>(false)
movieMapStore.mode = 'loc'
const modal = useModalStore()

const setLocById = (id : number) =>{
    if(!(id in movieMapStore.locations)){
        //TODO: there should be a 404 response here
        //console.log("could not find this location")
        router.push({name:'movieInfo'})
        return
    }
    movieMapStore.selectedLocationIdx = id
    
}

const openImageModal = (url : string, caption: string) => {
    if(!url) return

    modal.openModal({component: PictureModal, props: {url}})
}

watch(locFetchingStatus, (newStatus : apiStatus) => {
        if(!awaitingFetch.value||!route.params.loc_id) return
        if (newStatus == 'success'){
            awaitingFetch.value=false
            setLocById(Number(route.params.loc_id))
        }
    }, {immediate: true})

watch(() => route.params.loc_id, (loc_id ) => {
    if(movieMapStore.locFetchingStatus !='success'){
        awaitingFetch.value=true
    }
    else{
        setLocById(Number(loc_id))
    }
}, {immediate: true})

</script>
<template>
    <div style="height: 100%; padding: 13px;">
        <div class="scene section">
            <div class="main-img-container" id="scene">
                <Image class="main-img" :src="movieMapStore.selectedLocation?.scene_img"
                 :caption="movieMapStore.selectedLocation?.scene_img_desc"
                 expandable/>
            </div>
            
            <h2>{{ movieMapStore.selectedLocation?.title }}</h2>
            <hr>
            <p class="location-info blog">{{ movieMapStore.selectedLocation?.scene_desc }}</p>   
        </div>
        <div>
            <h2>Where was it filmed?</h2>
            <hr style="margin-right: 34%">
            <div class="location section">
                <div class="main-img-container" id="">

                    <Image class="main-img"
                     :src="movieMapStore.selectedLocation?.loc_img"
                     :caption="movieMapStore.selectedLocation?.loc_img_desc"
                     expandable/>
                </div>
                <p class="blog">{{ movieMapStore.selectedLocation?.location_desc }}</p>
                <GoogleStreetViewEmbed v-if="false" url="https://www.google.com/maps/embed?pb=!4v1705017146462!6m8!1m7!1sFmYUSEP8-OyuqwHCBA8_Ig!2m2!1d34.04107625525651!2d-118.2314945060246!3f339.1876516681286!4f-12.61778220327082!5f0.7820865974627469"></GoogleStreetViewEmbed>  

            </div>

        </div>
    </div>
</template>
<style scoped>

    .section {
        overflow: hidden;
        
    }

    .scene {
        margin-bottom: 24px;
    }
    .main-img-container {
        overflow: hidden;
        max-width: 50%;
        margin:10px;
    }
    
    .scene  .main-img-container {
        float: left;
    }
    .location  .main-img-container  {
        float: right;
    }


    .main-img {
        width:100%;
        height: 100%;
        object-fit: contain;
        cursor: pointer;
    }

    .scene  .main-img {
        max-height: 30vh;
    }

    .location  .main-img {
        max-height: 35vh;
    }

    .location-info {
        min-height: 5rem;
    }
</style>