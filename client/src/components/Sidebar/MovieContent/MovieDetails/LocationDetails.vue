<script setup lang="ts">
console.log('running locationDetails setup script')

import { watch, ref } from 'vue';
import { useMovieMapStore } from '@/stores/MovieMap.store'
import type { apiStatus } from '@/types/types';
import { useRoute, useRouter } from 'vue-router';
import { storeToRefs } from 'pinia';

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
    <div>
        <div>
            location details
        </div>
        {{ movieMapStore.selectedLocation }}
    </div>
</template>
<style></style>