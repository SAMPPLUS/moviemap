<script setup lang="ts">
import Sidebar from './components/Sidebar/Sidebar.vue'
import Map from './components/Map.vue';
import { useRoute } from 'vue-router';
import { useMovieMapStore } from './stores/MovieMap.store';
import { onMounted } from 'vue';
const route = useRoute();




</script>

<template>
  <div class="main-element">
    <Sidebar />
  </div>
  <div class="main-element">
    <Map :startzoom="3" ></Map>
  </div>
</template>

<style scoped>
header {
  line-height: 1.5;
  width: 100%;
  overflow: hidden;
}

.main-element {
  width: 100%;
}




@media (min-width: 1024px) {


}
</style>
