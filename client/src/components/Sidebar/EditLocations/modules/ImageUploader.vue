<script setup lang="ts">
    import { ref} from 'vue';
    import axios from 'axios';
    const previewImage = ref()
    const emit =defineEmits(['newImage'])
    //const imageFile = ref<File>()


    const uploadImage = (e: Event) => {
        const image = (e.target as HTMLInputElement).files?.[0]
        if(!image) return
        const reader = new FileReader();
        reader.readAsDataURL(image);
        reader.onload = e =>{
            previewImage.value = e.target?.result;
            console.log(previewImage);
        };
        emit('newImage', image)
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