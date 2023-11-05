<script setup lang="ts">
    import { useMovieMapStore } from '@/stores/MovieMap.store';
    import { useEditLocationStore } from '@/stores/EditLocation.store';
    import { ref } from 'vue';
    import { useRoute } from 'vue-router';
    const movieMapStore = useMovieMapStore()
    const editStore = useEditLocationStore()
    movieMapStore.setMode('edit')
    movieMapStore.fetchMovieDetails(useRoute().params.id as string)

    

</script>
<template>
    <div class="sidebar-comp" >
        <h1>EDIT</h1>
        
        <input type="number" v-model.number="editStore.selectedLocation.position.lat" step="0.1">
        <input type="number" v-model.number="editStore.selectedLocation.position.lng" step="0.1">
        {{ editStore.selectedLocation?.position }}

    </div>
</template>