<script setup lang="ts">
import { ref } from 'vue';
import { useModalStore } from '@/stores/Modal.store';
const modal = useModalStore();

const src = ref<string>(modal.props.src)
if(!src.value){
    console.log(src.value)
    modal.closeModal()
}

const caption = ref<string>(modal.props?.caption)


</script>

<template>
    <div class="outer-modal">
    <div class="inner-modal">
        <div class="container">
            <div id="picture">
                <img v-if="src" :src="src"/>
            </div>
            <div id="info"> 
                {{caption}}
            </div>
        </div>
    </div>
    </div>  
    
</template>

<style scoped>
.outer-modal {
    background-color: rgb(235, 235, 235);
    padding: 9px;
    border-radius: 5px;
}
.inner-modal {
    width: fit-content ;
}
.container {
    width: 100%;
    height: 100%;
}

#picture{
    height: 93%;
    width: 100%;
    display: flex;
    justify-content: center;
}

#info{
    height:7%;
    color: black;
    text-align: center;
}

img {
    max-height: 82vh;
    max-width: 80vw;
    object-fit: contain;
}
</style>