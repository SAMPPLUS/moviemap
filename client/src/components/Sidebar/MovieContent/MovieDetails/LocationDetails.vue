<script setup lang="ts">

import { watch, ref } from 'vue';
import { useMovieMapStore } from '@/stores/MovieMap.store'
import type { apiStatus } from '@/types/types';
import { useRoute } from 'vue-router';
import { storeToRefs } from 'pinia';

const findId = (id : string) =>{
    var idx = movieMapStore.locations.findIndex(o => o.id == id);
    if(idx>-1){
        movieMapStore.setSelectedLocationIdx(idx)
    }
    //else 404
}


const movieMapStore = useMovieMapStore()
const {locFetchingStatus} = storeToRefs(movieMapStore)
var loc_id = useRoute().params.loc_id as string

console.log(locFetchingStatus.value)
if(movieMapStore.locFetchingStatus !='success'){
    watch(locFetchingStatus, async (newStatus : apiStatus, oldStatus : apiStatus) => {
        findId(loc_id)
    })
}
else{
    findId(loc_id)
}

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