<script setup lang="ts">
import { watch, ref, computed } from 'vue';
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
const movieMapStore = useMovieMapStore()
const {locFetchingStatus} = storeToRefs(movieMapStore)
const awaitingFetch = ref<boolean>(false)
movieMapStore.mode = 'loc'
const modal = useModalStore()




const specificity_values = {
        'street': 0,
        'city': 1,
        'region': 2,
        'country': 3,
        'hide': 4
    }

const showAddressPart = (spec_val : number) => {
    if(!movieMapStore.selectedLocation) return false
    return (specificity_values[movieMapStore.selectedLocation.specificity as keyof typeof specificity_values]<=spec_val)
}

const atleastOneAddressPart = computed<boolean>(() => {return (Boolean(movieMapStore.selectedLocation) && (Boolean(movieMapStore.selectedLocation?.country))) })

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
            
            <h3 style="color: rgb(196, 196, 196)">{{ movieMapStore.selectedLocation?.title }}</h3>
            <hr style="margin-bottom: 8px">
            <p class="location-info blog">{{ movieMapStore.selectedLocation?.scene_desc }}</p>   
        </div>
        <div>
            <div style="margin-bottom: 8px;">
                    <h4 style="font-weight: 500; color: rgb(177, 177, 177); ">Where was it filmed?</h4>
                <hr >
            </div>
            <div class="location section">
                
                <div class="main-img-container" id="">

                    <Image class="main-img"
                     :src="movieMapStore.selectedLocation?.loc_img"
                     :caption="movieMapStore.selectedLocation?.loc_img_desc"
                     expandable/>
                </div>
                
                
                <div class="loc-details">
                    
                    <div id="address" v-show="atleastOneAddressPart">
                        <h2 >{{ movieMapStore.selectedLocation?.location_name }}</h2>
                        <div class="address-parts">
                            <div v-if="showAddressPart(0) && movieMapStore.selectedLocation?.street ">
                                {{ movieMapStore.selectedLocation.street }}, <br>
                            </div>
                            <div>
                                <span v-if="showAddressPart(1) && movieMapStore.selectedLocation?.city"> {{ movieMapStore.selectedLocation.city }}, </span>
                                <span v-if="showAddressPart(2) && movieMapStore.selectedLocation?.region"> {{ movieMapStore.selectedLocation.region }}, </span>
                                <span v-if="showAddressPart(3) && movieMapStore.selectedLocation?.country"> {{ movieMapStore.selectedLocation.country }} </span>
                            </div>
                        </div>
                        <hr>
                    </div>
                    <p class="blog">{{ movieMapStore.selectedLocation?.location_desc }}</p>

                </div>
                
            </div>
            <div style="margin-bottom: 22px;">
                <h4 style="font-weight: 500; color: rgb(177, 177, 177); ">Street View</h4>
                <hr>
            </div>
            <GoogleStreetViewEmbed style="margin-top: 4px;" v-if="movieMapStore.selectedLocation?.g_streetview_embed_url" :url="movieMapStore.selectedLocation?.g_streetview_embed_url"></GoogleStreetViewEmbed>  


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
    }
    
    .main-img-container {
        float: left;
        margin: 2px 14px 10px 0;
    }
   


    .main-img {
        width:100%;
        height: 100%;
        object-fit: contain;
        cursor: pointer;
    }

    #address {
        margin: 12px 0 ;
        line-height: 1.15;

    }

    .address-parts {
        margin: 0 16px 0 0 ;
        font-size: .9rem;
        color: rgb(159, 159, 159);
        margin-bottom: 15px;
    }
    .scene  .main-img {
        max-height: 31vh;
    }

    .location  .main-img {
        max-height: 36vh;
    }

    .location-info {
        min-height: 5rem;
    }


</style>