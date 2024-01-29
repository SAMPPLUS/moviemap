<script setup lang="ts">
  import { ref } from 'vue'
  import { useMovieMapStore } from '@/stores/MovieMap.store'
  import { useModalStore } from '@/stores/Modal.store';
  import Image from '@/components/Util/Image.vue';
  
  const store = useMovieMapStore();
  const modal = useModalStore();
  store.setMode('movie')



</script>

<template>
<div class="movie-details">
    <div class="details-container">
        <div class="frame poster">
            <Image :src="store.filmDetails?.poster_path" :caption="store.filmDetails?.title" expandable external poster/>
        </div>
        <div class="movie-info">
            <div class="movie-header" v-if="store.filmDetails">
                <h1 id="title" >
                    {{ store.filmDetails?.title }}
                </h1>
                <div id="byline">
                    <p id="release">{{ store.releaseYear }}</p>
                    <p id="director" v-if="store.filmDetails.director"> Dir. {{ store.filmDetails.director }}</p>
                </div>
                <hr>
            </div>
            <div class="overview">
                <p class="blog">{{ store.filmDetails?.overview }}</p>
            </div>
        </div>     
    </div>
    <h2 style="margin-left: 12px;"><span style="font-size: 2.1rem; margin-right: .5rem;">{{Object.keys(store.locations).length}}</span>Locations</h2>
    <hr>
</div>

</template>

<style scoped>
.movie-details {
    margin-top: 1rem;
    padding: 0 20px 0 20px;
}
.frame {
    border: 1px solid white;
    height: fit-content;
    display: flex;
    border-radius: 4px;
    overflow: hidden;
    float: left;
    margin-right: 12px;
    margin-bottom: 8px;
}

.poster {
    width: 191px;
    max-width: 30%;
}

.details-container {
    padding: 0 0 0 20px;
    overflow: hidden;
    margin-bottom: 20px;
}

.movie-details .movie-header {
    text-align: left;
}

.movie-details .movie-header #title {
    max-height: 110px;
    overflow-y: hidden;
    font-family: 'marcellus';
    font-weight: bold;
}

#byline {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
}

.movie-details .movie-header #release {
    margin-left: 2px;
}

.movie-details .movie-header #director {
    margin-right: 10px;
}

.movie-details .overview {
    margin-top: 12px;
    text-align:left;
}

.frame img {
  width: 100%;
}
</style>