<script setup lang="ts">
console.log('running locationDetails setup script')

import { watch, ref } from 'vue';
import { useMovieMapStore } from '@/stores/MovieMap.store'
import type { apiStatus } from '@/types/types';
import { useRoute, useRouter } from 'vue-router';
import { storeToRefs } from 'pinia';
import { IMG_PATH } from "@/util/const";
import GoogleStreetViewEmbed from '../GoogleStreetViewEmbed.vue';


const router = useRouter()
const route = useRoute()
console.log(route.params)
const movieMapStore = useMovieMapStore()
const {locFetchingStatus} = storeToRefs(movieMapStore)
const awaitingFetch = ref<boolean>(false)
movieMapStore.mode = 'loc'

const setLocById = (id : number) =>{
    if(!(id in movieMapStore.locations)){
        //TODO: there should be a 404 response here
        //console.log("could not find this location")
        router.push({name:'movieInfo'})
        return
    }
    movieMapStore.selectedLocationIdx = id
    
}

const openImageModal = () => {
    console.log('open image modal')
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
            <img class="main-img main-scene-img"
            :src="IMG_PATH+movieMapStore.selectedLocation?.scene_img"
            v-if="movieMapStore.selectedLocation?.scene_img_desc"
            @click="openImageModal" >
            <h1>{{ movieMapStore.selectedLocation?.title }}</h1>
            <p>{{ movieMapStore.selectedLocation?.scene_desc }}</p>   
        </div>
        <div>
            <h3>Where was it filmed?</h3>
            <div class="now section">
                <img class="main-img main-loc-img" :src="IMG_PATH+movieMapStore.selectedLocation?.loc_img" v-if="movieMapStore.selectedLocation?.scene_img_desc">
                <p>{{ movieMapStore.selectedLocation?.location_desc }}</p>
                <GoogleStreetViewEmbed url="https://www.google.com/maps/embed?pb=!4v1705017146462!6m8!1m7!1sFmYUSEP8-OyuqwHCBA8_Ig!2m2!1d34.04107625525651!2d-118.2314945060246!3f339.1876516681286!4f-12.61778220327082!5f0.7820865974627469"></GoogleStreetViewEmbed>  

            </div>

        </div>
    </div>
</template>
<style scoped>

    .section {
        overflow: hidden;
        
    }

    .scene {
        margin-bottom: 14px;
    }
    .main-img {
        max-width: 50%;
        max-height: 30vh;
        margin:10px;
    }
    
    .main-scene-img {
        float: left;
        cursor: pointer;
    }
    .main-loc-img {
        float: right
    }
</style>