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
  <div class="sidebar">
    <div class="top-bar">
      <h1>Movie Map</h1>
    </div>
    <div id="sidebar-content">
      <MovieDetails></MovieDetails>
      <SceneSelector style="margin-top: auto;"></SceneSelector>
    </div>
  </div>

  
</template>

<style scoped>
.sidebar {
  height: 100%
}
.top-bar {
  position: absolute;
  background: rgb(37, 37, 37);
  left:0;
  height: 65px;
  width: 46vw;
  padding: 0 20px 0 20px;
}
.wrapper {
  padding: 20px;
}

#sidebar-content {
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  height: 100%;
  
  padding: 80px 0px 0 0px;
}

</style>