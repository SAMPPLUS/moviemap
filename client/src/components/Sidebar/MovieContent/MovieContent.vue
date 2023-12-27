<script setup lang="ts">
    import SceneSelector from './MovieDetails/SceneSelector.vue';
    import { useMovieMapStore } from '@/stores/MovieMap.store';
    import { useRoute } from 'vue-router';
    import movieGeoService from '@/api/movieGeoService';
    
    const store = useMovieMapStore();
    var movie_id = useRoute().params.movie_id as string
    movieGeoService.fetchMovie(movie_id)
    movieGeoService.fetchLocations(movie_id)
    

</script>

<template>
<div class="sidebar-comp" id="movie-content">
    <router-view style="overflow-y: auto; background-color: var(--color-background);" name="mainMovieContent"></router-view>
    <SceneSelector v-show="false" style="margin-top: auto; height: 20%; min-height: 150px; "></SceneSelector>
</div>

</template>

<style>
#movie-content {
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
}
</style>