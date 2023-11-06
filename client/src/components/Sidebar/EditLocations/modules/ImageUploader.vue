<script setup lang="ts">
    import { ref } from 'vue'
    const previewImage = ref()


    interface InputFileEvent extends Event {
        target: HTMLInputElement;
    }
    const uploadImage = (e: Event) => {
        const image = (e.target as HTMLInputElement).files?.[0]
        if(!image) return
        const reader = new FileReader();
        reader.readAsDataURL(image);
        reader.onload = e =>{
            previewImage.value = e.target?.result;
            console.log(previewImage);
        };
    }
</script>

<template>
    <div>
       <img :src="previewImage" class="uploading-image" />
       <input type="file" accept="image/jpeg" @change=uploadImage>
    </div>
 </template>

 <style>
 
 .uploading-image {
    max-width: 240px;
    max-height: 200px;
 }

</style>