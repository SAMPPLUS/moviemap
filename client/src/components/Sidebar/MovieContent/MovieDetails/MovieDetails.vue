<script setup lang="ts">
  import { ref } from 'vue'
  import { useMovieMapStore } from '@/stores/MovieMap.store'

  const store = useMovieMapStore();

</script>

<template>
<div class="movie-details">
    <div class="frame poster">
        <img  v-bind:src="store.filmDetails?.poster_path"> 
    </div>
    <div class="details-container">
        <div class="movie-info">
            <div class="header" v-if="store.filmDetails">
                <h1 id="title" >
                    {{ store.filmDetails?.title }}
                </h1>
                <div id="byline">
                    <p id="release">{{ store.releaseYear }}</p>
                    <p id="director"> Dir. {{ store.filmDetails.director }}</p>
                </div>
                <div style="clear: both;"></div>
            </div>

            <div class="overview">
                <p>{{ store.filmDetails?.overview }}</p>
            </div>
        </div>     
    </div>
</div>

</template>

<style scoped>
.movie-details {
    display: grid;
    grid-template-columns: repeat(6, 1fr);;
    padding: 0 20px 0 20px;
}
.frame {
    border: 1px solid white;
    height: fit-content;
}

.poster {
    grid-column: 1 / span 2;
    width: 191px;
}

.details-container {
    grid-column: 3 / span 4;
    padding: 0 0 0 20px;
}

.movie-details .header {
    text-align: left;
    border-bottom: 1px solid;
}

.movie-details .header #title {
    max-height: 110px;
    overflow-y: hidden;
    font-family: crimson;
    font-weight: bold;
}

.movie-details .header #release {
    float: left;
    margin-left: 2px;
}

.movie-details .header #director {
    float : right;
    margin-right: 10px;
}

.movie-details .overview {
    margin-top: 12px;
    text-align:left;
    overflow-y: hidden;
}

.frame img {
  width: 100%;
}
</style>../assets/stores/MovieMap.store