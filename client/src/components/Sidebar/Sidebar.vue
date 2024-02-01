<script setup lang="ts">
  import { ref } from 'vue'
  import { useMovieMapStore } from '@/stores/MovieMap.store'
  import MovieContent from './MovieContent/MovieContent.vue';
  import { useCurrentUser } from 'vuefire';
  import { useModalStore } from '@/stores/Modal.store';
  import { useUserStore } from '@/stores/User.store'
  import LoginModal from '../Modal/inner/LoginModal.vue';
  import { useToastStore } from '@/stores/Toast.store';
  import { useRouter } from 'vue-router';
  import SceneSelector from './MovieContent/MovieDetails/SceneSelector.vue';
  import { storeToRefs } from 'pinia';
  import getOS from '@/util/getOs';

  const router = useRouter();
  const movieMapStore = useMovieMapStore();
  const userStore = useUserStore();
  const modal = useModalStore();
  const toast = useToastStore();
  const {user} = storeToRefs(userStore)
  const os = ref<string|null>(getOS())
  userStore.getUser();

  const clickLogo = (e: Event) => {
    e.preventDefault()
    router.push({name: 'explore'})
  }

  const clickBack = (e: Event) => {
    e.preventDefault()
    if(movieMapStore.mode == 'loc') router.push({name: 'movieInfo'})
    else if (movieMapStore.mode == 'movie') router.push({name: 'explore'})
  }  

  const showTestToast = () => {
    toast.openToast({text: 'this is a toast that is a bit longer. More text to display. Lorem Ipsum more text more text. extrabagant', duration: 1.2, type: 'warning'})
  }

</script>

<template>
  <div class="sidebar">
    <div class="top-bar">
      <div class="top-bar-inner">
        <a id="topleft" href="#" v-if="['loc','movie'].includes(movieMapStore.mode)" @click="clickBack">
          <img src="@/assets/icons/chevron-left.svg"/>
        </a>
        <div id="title-container">
          <a href="/"  @click="clickLogo">
            <h1 id="site-title"><span style="">Scene</span><span style="">Geo</span></h1>
          </a>
        </div>
        <div id="topright" >
          <button @click="showTestToast">toast</button>
          <button v-if="user" @click="userStore.signOut"> Sign Out</button>
          <button v-else @click="modal.openModal({component: LoginModal})"> login </button>
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
      <div id="content-container" :class="{'windows-scrollbar': os=='windows'}">
        <router-view/>
      </div>
      <SceneSelector></SceneSelector>
    </div>
  </div>
</template>

<style scoped>


#topleft {
  display: flex;
  flex-direction: column;
  justify-content: center;
}

#topright {
  display: flex;
  flex-direction: column;
  justify-content: center;
  margin-left:auto
}

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

#title-container a:hover {
  background-color: unset;
}

#site-title {
  margin: 0;
  font-family: 'cushion-bold';
  font-weight: 700;
  font-size: 3.4rem;
  font-weight: unset;
  color: white;
  cursor: pointer;
  background-image: linear-gradient(45deg, #f3ec78, #af4261);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

#site-title:hover {
  background-image: linear-gradient(45deg, #f3ec78, #af4261);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  opacity: .8;
  transition: 0.2s;
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
  z-index: 50;
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
  display: flex;
  flex-direction: column;
}

#content-container {
  flex-grow: 1;
  overflow-y: scroll;
  background-color: var(--color-background);
}


.windows-scrollbar::-webkit-scrollbar {
  width: 10px;               /* width of the entire scrollbar */
}

.windows-scrollbar::-webkit-scrollbar-track {
  background: var(--color-background)       /* color of the tracking area */
}

.windows-scrollbar::-webkit-scrollbar-thumb {
  background-color: rgb(109, 109, 109);    /* color of the scroll thumb */
  border-radius: 12px;       /* roundness of the scroll thumb */
}
</style>