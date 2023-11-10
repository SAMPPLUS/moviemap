<script setup lang="ts">
    import ImageUploader from './ImageUploader.vue'
    import { useMovieMapStore } from '@/stores/MovieMap.store';
    import { useEditLocationStore } from '@/stores/EditLocation.store';
    import { ref, onBeforeMount} from 'vue';
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
    editStore.appendImageField();
    editStore.appendImageField();

    const inputLatLng = (e : Event, type: ('lat' | 'lng')) => {
        if(!e.target) return
        var val : number = Number((e.target as HTMLTextAreaElement).value)
        if(type == 'lat'){
            //val = Math.min(Math.max(val, -90), 90)
            editStore.newLocation.position.lat = val
        }
        else{
            //val = Math.min(Math.max(val, -180), 180)
            editStore.newLocation.position.lng = val
        }
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
            <div>{{ editStore.images }}</div>
            <div class="edit-row">
                <input type="text" v-model="formData.title" placeholder="title">
            </div>
            <div class="edit-row">
                <input type="number" min="-90" max="90"   :value="editStore.wrappedNewLocation.lat" @input="inputLatLng($event,'lat')" step="0.1">
                <input type="number"  :value="editStore.wrappedNewLocation.lng" @input="inputLatLng($event, 'lng')" step="0.1">
            </div>
            <div class="edit-row">
                <textarea v-model="formData.description" spellcheck="true" placeholder="description"></textarea>
            </div>

            <h1>Images</h1>
            
            <ImageUploader v-for="(image,index) in editStore.images" @new-image="" :index="index"/>

            
            <button @click="submit"> SUBMIT</button>
        </div>
    </div>
</template>

<style scoped>

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
</style>@/stores/EditLocation.store