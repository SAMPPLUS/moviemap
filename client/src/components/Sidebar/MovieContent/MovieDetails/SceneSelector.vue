<script  setup lang="ts">
import { useMovieMapStore } from '@/stores/MovieMap.store';
import { ref, onMounted } from 'vue';
import { useRouter} from 'vue-router';

const store = useMovieMapStore()
const router = useRouter()

const hl_img : string = "/api/images/highansdlow042.jpg";

const displayScroll = async (element : HTMLDivElement) => {
    setTimeout(function(){
        element.scrollIntoView({behavior:'smooth'})
        
    } , 150);
}

const onCardClick = (index: number) =>{
    
    store.setSelectedLocationIdx(index);
    router.push({name: 'movieLocation'})
}

const cardImageError = (e : Event) => {
    console.log(e)
    //(e.target as HTMLImageElement).src = store.placeholderStill
}

const cardRefs = ref<HTMLDivElement[]>([])


store.$onAction(
        ({
          name, // name of the action
          store, // store instance, same as `someStore`
          args, // array of parameters passed to the action
          after, // hook after the action returns or resolves
          onError, // hook if the action throws or rejects
        }) => {

          if(name=='setSelectedLocationIdx'){
            if(args[0] != undefined){
                cardRefs.value[args[0]].scrollIntoView({behavior: 'smooth', block: 'center', inline: 'center'})
            }
            
          }
        })

onMounted(() => {
    /*
    if(lastcard.value){
        lastcard.value.scrollIntoView({behavior: 'instant'})
    }
    if(card1.value){
        displayScroll(card1.value);
    }*/
    
})
</script>

<template>
<div class="scene-selector">
    <div class="scroller">
        <div class="end" ></div>
        <div class="card" v-for="(location, index) in store.locations" ref=cardRefs @click="onCardClick(index)" onerror="cardImageError()">
            <img :src="(location.main_img_path) || (store.placeholderStill)" class="loc-image">
        </div>
        
        <div class="end"></div>
    </div>
</div>
</template>

<style>
.scene-selector {
    max-width: 100%;
    width: 100%;
    padding: 15px 0 18px 0;
    outline: 1px solid rgb(24, 24, 24);
    height: 20%;
    background: rgb(0, 0, 0);
    border-right: 2px solid black;
    border-left: 2px solid black;
    overflow-x: scroll;
    scrollbar-color: white;
    overflow-x: scroll;
    -webkit-overflow-scrolling: touch;
    overflow-y: hidden;
}
.scroller {
    min-width: 100%;
    height: 100%;
    background: rgb(0, 0, 0);
    display: flex;
    flex-direction: row;
    scrollbar-color: white;
}

.end {
    min-width: 80px;
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