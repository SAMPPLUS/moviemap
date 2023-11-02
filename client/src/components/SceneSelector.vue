<script  setup lang="ts">
import { ref, onMounted } from 'vue';
import type { Ref } from 'vue';

const hl_img : string = "/images/spaceodyssey.jpeg";

const displayScroll = async (element : HTMLDivElement) => {
    setTimeout(function(){
        element.scrollIntoView({behavior:'smooth'})
        
    } , 150);
}

const card1 = ref<HTMLDivElement>()
const card2 = ref<HTMLDivElement>()
const lastcard = ref<HTMLDivElement>()

onMounted(() => {
    if(lastcard.value){
        lastcard.value.scrollIntoView({behavior: 'instant'})
    }
    if(card1.value){
        displayScroll(card1.value);
    }
    
    

})
</script>

<template>
<div class="scene-selector">
    <div class="scroller">
        <div class="end" ></div>
        <div class="card" ref="card1">
            <img :src="hl_img" class="loc-image">
        </div>
        <div class="card" >
            <img :src="hl_img" class="loc-image">
        </div><div class="card" >
            <img :src="hl_img" class="loc-image">
        </div><div class="card" >
            <img :src="hl_img" class="loc-image">
        </div><div class="card" >
            <img :src="hl_img" class="loc-image">
        </div><div class="card" ref="card2" >
            <img :src="hl_img" class="loc-image">
        </div><div class="card" ref="lastcard">
            <img :src="hl_img" class="loc-image">
        </div>
        <div class="end"></div>
    </div>
</div>
</template>

<style>
.scene-selector {
    outline: 1px solid rgb(24, 24, 24);
    height: 100%;
    background: rgb(0, 0, 0);
    overflow-x: scroll;
    scrollbar-color: white;
}
.scroller {
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
    margin: 10px 5px 10px 5px;
    height: 120px;
    aspect-ratio: 16 / 9;
    background: rgb(86, 86, 86);
    border-radius: 5px;
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
    border-radius: 8px;
}
</style>