<script setup lang="ts">
    import { ref} from 'vue';
    import axios from 'axios';
    import { useEditLocationStore } from '@/stores/EditLocation.store'
    import {type imageObject } from "@/interfaces/edit.int"
    import { storeToRefs } from 'pinia';
    import { IMG_PATH } from '@/util/const';


    const previewImage = ref()
    const emit =defineEmits(['newImage', 'delete'])
    const editStore = useEditLocationStore();
    //const imageFile = ref<File>()
    const props  = defineProps<{
        index: number,
        imageObject: imageObject,
        type: (1|2)
    }>()
    const {waiting} = storeToRefs(editStore)

    const imgGroup = ref()

    if(props.type ==1){
        imgGroup.value = editStore.sceneImages
    }
    else{
        imgGroup.value = editStore.locationImages
    }

    const thisImage = ref<imageObject>(props.imageObject)
    // if(thisImage.value.file){
    //     console.log(thisImage.value.file)
    //     previewImage.value=thisImage.value.file
    // }

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

    const checkCompletion = () => {
        
    }

    
</script>

<template>
    <div class="image-upload">
        <div class="upload-content">
            <div class="upload-frame">
                <img :src="IMG_PATH + thisImage.file_name" class="uploading-image" v-if="thisImage.status=='update'">
                <img :src="previewImage" class="uploading-image" v-else="thisImage.status=='new'"  />
            </div>
            <div class="image-data">
                <div class="delete-row"> <button @click="$emit('delete')" :disabled="waiting" v-if="thisImage.status=='new'">delete</button></div>
                <div class="image-metadata">
                    <textarea maxlength="140" placeholder="caption" v-model="thisImage.description" :disabled="waiting"></textarea>
                    <div class="image-options">
                        <input type="checkbox"  name="main" :checked="thisImage.main" :disabled="thisImage.main || waiting" @click="$event => editStore.setMainImage($event, props.type, thisImage)" >
                        <label for="main"> Main </label>
                    </div>
                </div>
            </div>
        </div>
        <div >
            <input type="file" accept="image/jpeg" v-if="thisImage.status == 'new'" @change=uploadImage  :disabled="waiting">
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

.image-data {
    flex-grow: 1;
    width: 100%;
    display: flex;
    flex-direction: column;
    padding-left: 10px;
}

.delete-row {
    text-align: right;
}
.image-metadata {
    flex-grow: 1;
    display: flex;
    flex-direction: column-reverse;
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