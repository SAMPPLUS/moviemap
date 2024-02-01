<script setup lang="ts">
import ExploreCard from './ExploreCard.vue';
import movieGeoService from '@/api/movieGeoService';
import { ref, computed } from 'vue';
import { useMovieMapStore } from '@/stores/MovieMap.store';
import { useRouter } from 'vue-router';

const movie_list = ref<any[]>([])
const movieMapStore = useMovieMapStore()
const router = useRouter()
movieMapStore.mode = 'home';
movieGeoService.fetchMovieList().then((data) => {
    movie_list.value = data.data
}).catch((e : Error) => {
    console.log(e);
})



const filter_str = ref<string>('')


</script>

<template>
    <div class="movie-list">
        <div class="search-container">
            <div> <!--<img  src="@/assets/icons/search.svg"/>--></div>
            <input id="m-search" v-model="filter_str" type="text" placeholder="Search">
        </div>
        <div class="list-outer">
            <div v-for="item in movie_list">
                <ExploreCard :movie_data="item" :filter_str="filter_str.toLowerCase()" />
            </div>
        </div>
    </div>
</template>

<style scoped>

.search-container{
    display: flex;
    flex-direction: row;
    margin-bottom: 12px;
}

#m-search {
    font-size: 2rem;
    flex-grow: 1;
    font-family: cushion;
    padding:8px;
}

#m-search:focus {
    outline: 0;
}
.movie-list {
    padding: 18px;
}
.list-outer{
    width: 100%;
}

.divider {
}

</style>