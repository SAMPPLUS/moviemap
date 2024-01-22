<script setup lang="ts">
    import Image from './Image.vue';
    import {type FilmDetails} from '@/stores/MovieMap.store'
    import {type PropType} from 'vue';

    const props = defineProps({
        filmDetails: Object as PropType<FilmDetails>
    })


</script>

<template>
    <div class="movie-card">
          <div>
            <Image class="card-image" style="height: 140px" :src="filmDetails?.poster_path" external/>
          </div>
          <div></div>
        </div>
</template>

<style scoped>

.movie-card {
    background-color: rgba(27, 27, 27, 0.5);

}

.card-image {
    margin: 8px;
    opacity: .9;
}
</style>