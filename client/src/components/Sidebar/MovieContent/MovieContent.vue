<script setup lang="ts">
    import SceneSelector from './MovieDetails/SceneSelector.vue';
    import { useMovieMapStore } from '@/stores/MovieMap.store';
    import { useRoute } from 'vue-router';
    
    const store = useMovieMapStore();
    store.setMode('movie')
    console.log(useRoute().params);
    
    store.fetchMovieDetails(useRoute().params.movie_id as string)
    

</script>

<template>
<div class="sidebar-comp" id="movie-content">
    <router-view style="overflow-y: auto; background-color: var(--color-background);" name="mainMovieContent"></router-view>
    <SceneSelector style="margin-top: auto; height: 20%; min-height: 150px; "></SceneSelector>
</div>

</template>

<style>
#movie-content {
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
}
</style>