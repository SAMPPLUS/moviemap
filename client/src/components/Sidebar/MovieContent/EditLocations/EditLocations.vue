<script setup lang="ts">
    import ImageUploader from './ImageUploader.vue'
    import { useMovieMapStore } from '@/stores/MovieMap.store';
    import { useEditLocationStore } from '@/stores/EditLocation.store';
    import { ref } from 'vue';
    import { useRoute } from 'vue-router';
    const movieMapStore = useMovieMapStore()
    const editStore = useEditLocationStore()

    type LocFormData = {
        movie_id: string;
        title: string;
        lat: number;
        lng: number;
        description: string;
        image: File
    }
    const imageFile = ref<File>()
    const formData = ref({ 
        title: '',
        description: ''})

    
    movieMapStore.setMode('edit')
    movieMapStore.fetchMovieDetails(useRoute().params.id as string)

    const newImage = (file : File) => {
        imageFile.value = file;
    }

    const submit = () => {
        console.log('submit')
        if(!imageFile.value){
            return
        }
        editStore.postNewLocation(imageFile.value, movieMapStore?.filmDetails?.id || '',  formData.value)
    }
    

</script>
<template>
    <div class="sidebar-comp" >
        <div id="location-form">
            <h1>New Location</h1>
            <div class="edit-row">
                <input type="text" v-model="formData.title" placeholder="title">
            </div>
            <div class="edit-row">
                <input type="number" v-model.number="editStore.selectedLocation.position.lat" step="0.1">
                <input type="number" v-model.number="editStore.selectedLocation.position.lng" step="0.1">
            </div>
            <div class="edit-row">
                <textarea v-model="formData.description" spellcheck="true" placeholder="description"></textarea>
            </div>
            
            <ImageUploader @new-image="newImage"/>

            <button @click="submit"> SUBMIT</button>
        </div>
        {{ formData }}
        {{ editStore.selectedLocation.position }}
    </div>
</template>

<style>

#location-form {
    padding: 0 30px 0 30px;
}

#location-form input {
    font-size: 18px;
}

#location-form  textarea{
    font-size: 18px;
    width: 100%;
    height: 8em;
    resize: vertical;
}

.edit-row {
    padding-bottom: 18px;
    display: flex;
    flex-direction: row;
}
</style>