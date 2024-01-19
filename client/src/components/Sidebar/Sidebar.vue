<script setup lang="ts">
  import { ref } from 'vue'
  import { useMovieMapStore } from '@/stores/MovieMap.store'
  import MovieContent from './MovieContent/MovieContent.vue';
  import { useCurrentUser } from 'vuefire';
  import { useModalStore } from '@/stores/Modal.store';
  import LoginModal from '../Modal/inner/LoginModal.vue';
  const user = useCurrentUser();
  const modal = useModalStore();

  
</script>

<template>
  <div class="sidebar">
    <div class="top-bar">
      <h1>Movie Map</h1>
      <div style="margin-left:auto;">
        <p v-if="user">Hello {{ user.providerData[0].displayName }}</p>
        <button v-else @click="modal.openModal({component: LoginModal})"> login </button>
      </div>

    </div>
    <div id="sidebar-content">
      <router-view/>
    </div>
  </div>
</template>

<style scoped>
.sidebar {
  height: 100%;
  position: relative;
}
.top-bar {
  display: flex;
  flex-direction: row;
  position: absolute;
  background: rgb(37, 37, 37);
  left:0;
  height: 65px;
  width: 100%;
  padding: 0 20px 0 20px;
}
.wrapper {
  padding: 20px;
}

#sidebar-content {
  height: 100vh;
  max-height: 100vh;
  padding: 65px 0px 0 0px;
}

</style>