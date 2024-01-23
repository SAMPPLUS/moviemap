<script setup lang="ts">
import ExploreCard from './ExploreCard.vue';
import movieGeoService from '@/api/movieGeoService';
import { ref } from 'vue';
import router from '@/routes';

const movie_list = ref<any[]>([])

movieGeoService.fetchMovieList().then((data) => {
    console.log(data)
    movie_list.value = data.data
}).catch((e : Error) => {
    console.log(e);
})

const navigateToMovie =(id: number) => {
    router.push({name:'movieInfo', params: {movie_id: id }})
}

</script>

<template>
    <div class="movie-list">
        <div></div>
        <div class="list-outer">
            <div v-for="item in movie_list">
                <ExploreCard :movie_data="item" @click="navigateToMovie(item.id)"/>
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