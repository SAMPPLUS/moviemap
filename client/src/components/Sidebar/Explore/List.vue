<script setup lang="ts">
import ExploreCard from './ExploreCard.vue';
import movieGeoService from '@/api/movieGeoService';
import { ref } from 'vue';
import { useMovieMapStore } from '@/stores/MovieMap.store';
import { useRouter } from 'vue-router';

const movie_list = ref<any[]>([])
const movieMapStore = useMovieMapStore()
const router = useRouter()
movieMapStore.mode = 'home';
movieGeoService.fetchMovieList().then((data) => {
    console.log(data)
    movie_list.value = data.data
}).catch((e : Error) => {
    console.log(e);
})


</script>

<template>
    <div class="movie-list">
        <div></div>
        <div class="list-outer">
            <div v-for="item in movie_list">
                <ExploreCard :movie_data="item" />
                <hr class="divider">
            </div>
        </div>
    </div>
</template>

<style scoped>
.list-outer{
    width: 100%;
    padding: 18px;
}

.divider {
}

</style>