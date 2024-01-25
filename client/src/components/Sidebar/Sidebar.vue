<script setup lang="ts">
  import { ref } from 'vue'
  import { useMovieMapStore } from '@/stores/MovieMap.store'
  import MovieContent from './MovieContent/MovieContent.vue';
  import { useCurrentUser } from 'vuefire';
  import { useModalStore } from '@/stores/Modal.store';
  import LoginModal from '../Modal/inner/LoginModal.vue';
  import { useRouter } from 'vue-router';

  const router = useRouter();
  const user = useCurrentUser();
  const modal = useModalStore();

  const clickLogo = (e: Event) => {
    e.preventDefault()
    router.push({name: 'explore'})
  }
  
</script>

<template>
  <div class="sidebar">
    <div class="top-bar">
      <div class="top-bar-inner">
        <div id="title-container">

          <a href="/" @click="clickLogo">
            <h1 id="site-title"><span style="">Scene </span><span style="">Geo</span></h1>
          </a>
        </div>
        <!--
        <div style="margin-left:auto;">
          <p v-if="user">Hello {{ user.providerData[0].displayName }}</p>
          <button v-else @click="modal.openModal({component: LoginModal})"> login </button>
        </div>
        -->
    </div>
    </div>
    <div id="sidebar-content">
      <router-view/>
    </div>
  </div>
</template>

<style scoped>
#title-container {
  display: flex;
  flex-direction: column;
  justify-content: center;
  height: 100%;
  position:absolute;
  left:0;
  right: 0;
  margin-left: auto;
  margin-right: auto;
  width: fit-content;
}

#site-title {
  margin: 0;
  font-family: newake;
  font-size: 3rem;
  font-weight: unset;
  color: white;
  cursor: pointer;
  
}
.sidebar {
  height: 100%;
  position: relative;
}
.top-bar {
  
  position: absolute;
  background: rgb(37, 37, 37);
  left:0;
  height: 65px;
  width: 100%;
}

.top-bar-inner {
  display: flex;
  flex-direction: row;
  width: 100%;
  height: 100%;
  position: relative;
}
.wrapper {
  padding: 20px;
}

#sidebar-content {
  height: 100vh;
  max-height: 100vh;
  padding: 65px 0px 0 0px;
  overflow-y: scroll;
}

</style>