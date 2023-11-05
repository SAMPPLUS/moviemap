<script setup lang="ts">
  import { ref } from 'vue'
  import { useMovieMapStore } from '@/stores/MovieMap.store'
  import MovieContent from './MovieContent/MovieContent.vue';


  
</script>

<template>
  <div class="sidebar">
    <div class="top-bar">
      <h1>Movie Map</h1>
    </div>
    <div id="sidebar-content">
      <router-view></router-view>
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
  width: 800px;
  padding: 0 20px 0 20px;
}
.wrapper {
  padding: 20px;
}

#sidebar-content {
  height: 100%;
  padding: 80px 0px 0 0px;
}

</style>../assets/stores/MovieMap.store