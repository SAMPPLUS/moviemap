<script  setup lang="ts">
import { useMovieMapStore } from '@/stores/MovieMap.store';
import { ref, onMounted } from 'vue';
import { useRouter} from 'vue-router';
import { storeToRefs } from 'pinia';
const movieMapStore = useMovieMapStore()
const router = useRouter()

const hl_img : string = "/api/images/highansdlow042.jpg";

const displayScroll = async (element : HTMLDivElement) => {
    setTimeout(function(){
        element.scrollIntoView({behavior:'smooth'})
        
    } , 150);
}

const onCardClick = (index: number) =>{
    
    movieMapStore.setSelectedLocationId(index);
    //router.push({name: 'movieLocation'})
}

const cardImageError = (e : Event) => {
    console.log(e)
    //(e.target as HTMLImageElement).src = store.placeholderStill
}

const cardRefs = ref<HTMLDivElement[]>([])

const {locFetchingStatus} = storeToRefs(movieMapStore)

onMounted(() => {
    movieMapStore.$onAction(
        ({
          name, // name of the action
          store, // store instance, same as `someStore`
          args, // array of parameters passed to the action
          after, // hook after the action returns or resolves
          onError, // hook if the action throws or rejects
        }) => {

          if(name=='setSelectedLocationId'){
            //console.log(cardRefs.value.length, args[0], Object.keys(movieMapStore.locations).length)
            if(args[0] != undefined && movieMapStore.locFetchingStatus=='success'){
                //cardRefs.value[args[0]].scrollIntoView({behavior: 'smooth', block: 'center', inline: 'center'})
            }
            
          }
        })
})
</script>

<template>
<div class="ss-container">
    <div style="color: white; background-color: black; font-size: 1em; padding-left: 10px;">hello</div>
    <div class="scene-selector">
        <div class="scroller">
            <div class="end" ></div>
            <div class="card" v-if="movieMapStore.locFetchingStatus == 'success'" v-for="(location, index) in movieMapStore.locations" ref=cardRefs @click="onCardClick(index)" onerror="cardImageError()">
                <img :src="(location.main_img_path) || (movieMapStore.placeholderStill)" class="loc-image">
            </div>
            
            <div class="end"></div>
        </div>
    </div>
</div>
</template>

<style>
.ss-container {
    display: flex;
    flex-direction: column;

}
.scene-selector {
    max-width: 100%;
    min-width: 100%;
    width: 100%;
    padding: 2% 0 2% 0;
    outline: 1px solid rgb(24, 24, 24);
    background-image: linear-gradient(black, rgb(62, 62, 62));
    border-right: 2px solid black;
    border-left: 2px solid black;
    scrollbar-color: white;
    overflow-x: scroll;
    -webkit-overflow-scrolling: touch;
    overflow-y: hidden;
    flex-grow: 1;
}
.scroller {
    min-width: 100%;
    height: 100%;
    display: flex;
    flex-direction: row;
    scrollbar-color: white;
}

.end {
    min-width: 60px;
}

.card {
    height: 100%;
    aspect-ratio: 16 / 9;
    margin: 0 1.5% 0 1.5%;
}

.card:hover {
    border: 1px solid;
    cursor: pointer;
}

.loc-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
    overflow: hidden;
}
</style>