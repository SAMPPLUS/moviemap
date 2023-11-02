<script setup lang="ts">
import HelloWorld from './components/HelloWorld.vue'
import TheWelcome from './components/TheWelcome.vue'
import Sidebar from './components/Sidebar.vue'
import Map from './components/Map.vue';
</script>

<template>
  <div class="main-element">
    <Sidebar />
  </div>
  <div class="main-element">
    <Map zoom="4" ></Map>
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
