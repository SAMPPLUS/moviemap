<script setup lang="ts">
  import { ref } from 'vue'
  import { useMovieMapStore } from './stores/MovieMap'

  const store = useMovieMapStore();
  const movie_details = ref({data: {}})
  const img_url : string = "https://image.tmdb.org/t/p/original/"
  const image_src = ref("")
  const func = async () => {
    store.getMovieDetails().then((ret) => {
      movie_details.value = ret.data;
      image_src.value = img_url + ret.data.poster_path
    })
  }
</script>

<template>
  <h1>Welcome to Movie Map</h1>
  <button @click="func">click</button>
  <div class="frame">
    <img  v-if='image_src' v-bind:src="image_src"> 
  </div>

  
</template>

<style scoped>

.frame {
  max-width: 200px;
}

.frame img {
  width: 100%;
}


</style>