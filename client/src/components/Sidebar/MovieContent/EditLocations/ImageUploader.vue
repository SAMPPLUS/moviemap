<script setup lang="ts">
    import { ref} from 'vue';
    import axios from 'axios';
    import { useEditLocationStore } from '@/stores/EditLocation.store';
    import {type imageObject } from "@/interfaces/edit.int"

    const previewImage = ref()
    const emit =defineEmits(['newImage'])
    const editStore = useEditLocationStore();
    //const imageFile = ref<File>()
    const props  = defineProps<{
        index: number
        type: (1|2)
    }>()

    const imgGroup = ref()

    if(props.type ==1){
        imgGroup.value = editStore.sceneImages
    }
    else{
        imgGroup.value = editStore.locationImages
    }

    const thisImage = ref<imageObject>(imgGroup.value[props.index as number])


    const uploadImage = async (e: Event) => {
        delete thisImage.value.id
        const image = (e.target as HTMLInputElement).files?.[0]
        if(!image) return
        const reader = new FileReader()
        reader.readAsDataURL(image)
        reader.onload = e =>{
            previewImage.value = e.target?.result
            console.log(previewImage)
        };

        let fd = new FormData();
        fd.append('image', image)
        await axios.post('/api/moviegeo/imgupload', fd).then((ret) => {
            if(ret.data.id){
                thisImage.value.id = ret.data.id
            }
        }).catch((e: Error) => {
            console.log(e)
        })
    }

    
</script>

<template>
    <div class="image-upload">
        <div class="upload-content">
            <div class="upload-frame">
                <img :src="previewImage" class="uploading-image" />
            </div>
            <div class="image-metadata">
                <textarea maxlength="140" placeholder="caption" v-model="thisImage.description"></textarea>
                <div class="image-options">
                    <input type="checkbox"  name="main" :checked="thisImage.main" :disabled="thisImage.main" @click="$event => editStore.setMainImage($event, props.type, props.index)">
                    <label for="main"> Main </label>
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
    width: auto;
    max-width: 230px;
    max-height: 160px;
    object-fit: contain;
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
    height: 4em;
    resize: vertical;
}


</style>