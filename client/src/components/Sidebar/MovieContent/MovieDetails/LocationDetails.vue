<script setup lang="ts">
import { useMovieMapStore } from '@/stores/MovieMap.store'
const movieMapStore = useMovieMapStore()


</script>
<template>
    location details
    
    {{ movieMapStore.selectedLocation }}
</template>
<style></style>