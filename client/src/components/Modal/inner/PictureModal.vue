<script setup lang="ts">
import { ref } from 'vue';
import { useModalStore } from '@/stores/Modal.store';
const modal = useModalStore();

const src = ref<string>(modal.props.src)
if(!src.value){
    modal.closeModal()
}

const caption = ref<string>(modal.props?.caption)


</script>

<template>
    <div class="outer-modal">
    <div class="modal">
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
    padding: 18px;
    border-radius: 5px;
}
.modal {
    height: 82vh;
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
    max-height: 100%;
    max-width: 100%;
    object-fit: contain;
}
</style>