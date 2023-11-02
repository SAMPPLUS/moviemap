<script setup lang="ts">
  import { ref } from 'vue'
  import { useMovieMapStore } from './stores/MovieMap.store'
  import MovieDetails from './MovieDetails.vue';
  import SceneSelector from './SceneSelector.vue';

  const store = useMovieMapStore();
  const movie_details = ref({data: {}})
  const img_url : string = "https://image.tmdb.org/t/p/original/"
  const image_src = ref("")
  const func = async () => {
    store.fetchMovieDetails()
  }

  func();

  
</script>

<template>
  <div class="top-bar">
    <h1>Movie Map</h1>
  </div>
  <div id="sidebar-content">
    <div style="">
      <MovieDetails></MovieDetails>
    </div>
      <SceneSelector></SceneSelector>
  </div>

  
</template>

<style scoped>
.top-bar {
  position: absolute;
  background: rgb(37, 37, 37);
  height: 65px;
  width: 50%;
  padding: 0 20px 0 20px;
}
.wrapper {
  padding: 20px;
}

#sidebar-content {
  display: grid;
  height: 100%;
  grid-template-rows: auto 160px;
  
  padding: 80px 0px 0 0px;
}

</style>