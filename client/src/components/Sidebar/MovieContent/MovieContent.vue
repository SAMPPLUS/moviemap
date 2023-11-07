<script setup lang="ts">
    import SceneSelector from './MovieDetails/SceneSelector.vue';
    import { useMovieMapStore } from '@/stores/MovieMap.store';
    import { useRoute } from 'vue-router';
    
    const store = useMovieMapStore();
    store.setMode('movie')
    
    store.fetchMovieDetails(useRoute().params.id as string)
    

</script>

<template>
<div class="sidebar-comp" id="movie-content">
    <router-view></router-view>
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