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
    <div class="image-upload">
        <div class="upload-content">
            <div class="upload-frame">
                <img :src="previewImage" class="uploading-image" />
            </div>
            <div class="image-metadata">
                <textarea maxlength="140"></textarea>
                <div class="image-options">
                    <input type="checkbox"  name="main" >
                    <label for="main"> Main </label>
                    <select name="image type" id="imagetype" style="margin-left: 10px">
                        <option value="1">movie still</option>
                        <option value="2">location image</option>
                    </select>
                </div>
                
            </div>
        </div>
        <div >
            <input type="file" accept="image/jpeg" @change=uploadImage>
        </div>
    </div>
 </template>

 <style scoped>

.image-upload {
    border-top: 1px solid;
    padding: 10px;
}

.upload-content {
    display: flex;
    flex-direction: row;
}
 
.upload-frame {
    display: flex;
    flex-direction: column-reverse;
    min-height: 160px;
    min-width: 240px;
    padding-right: 10px;
    border-right: 1px solid
}

.uploading-image {
    width: 230px;
    max-width: 230px;
    max-height: 160px;
}

.image-metadata {
    flex-grow: 1;
    display: flex;
    flex-direction: column-reverse;
    padding-left: 10px;
}

.image-options {
    display: flex;
    flex-direction: row;
    font-size: .7em;
    margin-bottom: 5px;
}
.image-metadata textarea {
    
    width: 100%;
    height: 40px;
    resize: vertical;
}


</style>