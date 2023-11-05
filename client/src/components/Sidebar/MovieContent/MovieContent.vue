<script setup lang="ts">
    import MovieDetails from './modules/MovieDetails.vue';
    import SceneSelector from './modules/SceneSelector.vue';
    import { useMovieMapStore } from '@/stores/MovieMap.store';
    import { useRoute } from 'vue-router';
    
    const store = useMovieMapStore();
    store.setMode('movie')
    
    store.fetchMovieDetails(useRoute().params.id as string)
    

</script>

<template>
<div class="sidebar-comp" id="movie-content">
    <MovieDetails></MovieDetails>
    <SceneSelector style="margin-top: auto;"></SceneSelector>
</div>

</template>

<style>
#movie-content {
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  
}
</style>