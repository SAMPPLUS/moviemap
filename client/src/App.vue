
<script setup lang="ts">
import Sidebar from './components/Sidebar/Sidebar.vue'
import Map from './components/Map.vue';
import Modal from './components/Modal/Modal.vue'
import { useRoute } from 'vue-router';
import { useMovieMapStore } from './stores/MovieMap.store';
import { onMounted } from 'vue';
import { useFirestore, useFirebaseAuth, useCurrentUser, getCurrentUser } from 'vuefire'

import { useModalStore } from '@/stores/Modal.store';

import InfoModal from './components/Modal/inner/InfoModal.vue'
import LoginModal from './components/Modal/inner/LoginModal.vue';
import * as firebaseui from 'firebaseui'

const route = useRoute();
const auth = useFirebaseAuth();



const modalStore = useModalStore()





</script>

<template>
  <div class="main-element">
    <Sidebar />
  </div>
  <div class="main-element">
    <Map :startzoom="3" ></Map>
  </div>
  <Modal/>
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
