<script setup lang="ts">
import Image from '@/components/Util/Image.vue';
import { useRouter } from 'vue-router';
import { ref, computed} from 'vue';
import { propsBinder } from '@vue-leaflet/vue-leaflet/dist/src/utils';
const router = useRouter();
const props = defineProps({
    movie_data : {
        type: Object,
        required: true
    }
})

const ctrlClick = (e: Event) => {
    console.log('ctrl click')
}
const navigateToMovie =(e : Event) => {
    e.preventDefault()
    router.push({name:'movieInfo', params: {movie_id: props.movie_data.id }})
}

const href = ref<string>('')

href.value = router.resolve({name:'movieInfo', params: {movie_id: props.movie_data.id }}).href


</script>
<template>
<a class="ex-card" :href="href" @click.exact="navigateToMovie" >
    <div class="pic-container">
        <Image class="img" :src="movie_data.poster_path" poster external/>
    </div>
    <div class="movie-info">
        <h3 id="title">{{movie_data.title}}</h3>
        <div id="year">
            <div>
                {{ movie_data.release_date ? movie_data.release_date.substring(0,4) : '' }}
            </div>
            <div>
                {{ movie_data.director }}
            </div>
            <div></div>
        </div>

    </div>
    <div class="loc-info">
        <div id="loc-count">
            <h4>{{ movie_data.loc_count }}</h4>
            <span class="small">locations</span>
        </div>
        
    </div>
</a>

</template>

<style scoped>
.ex-card {
    display: flex;
    flex-direction: row;
    height: 140px;
    cursor: pointer;
    color: white;
}

.ex-card:hover {
}

.pic-container {
    height: 100%;
    aspect-ratio: 2.4/3;
}

.img {
    height: 100%;
    object-fit: contain;
    padding: 10px;
}

.movie-info {
    width: 100%;
    display: flex;
    flex-direction: column;
    justify-content: center;
}

#title {
    margin-bottom: 0;
}

#year {
    display: flex;
    width: 100%;
    flex-direction: row;
    justify-content: space-between;
    font-size: .8rem;
}

.loc-info {
    width: fit-content;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    padding: 0 10px 0 10px;
}

#loc-count {
    line-height: 1;
    text-align: center;
}

.small {
    font-size: .8rem;
}
</style>