<script setup lang="ts">
import HelloWorld from './components/HelloWorld.vue'
import TheWelcome from './components/TheWelcome.vue'
import Sidebar from './components/Sidebar.vue'
import Map from './components/Map.vue';
</script>

<template>
  <header>

    <div class="wrapper">
      <Sidebar />
    </div>
  </header>

  <main>
    <div class="wrapper">
      <Map zoom="4" ></Map>
    </div>
  </main>
</template>

<style scoped>
header {
  line-height: 1.5;
}


@media (min-width: 1024px) {


}
</style>
