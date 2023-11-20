<script setup lang="ts">
    import ImageUploader from './ImageUploader.vue'
    import { useMovieMapStore } from '@/stores/MovieMap.store';
    import { useEditLocationStore } from '@/stores/EditLocation.store';
    import { ref, onBeforeMount} from 'vue';
    import { useRoute } from 'vue-router';
    const movieMapStore = useMovieMapStore()
    const editStore = useEditLocationStore()

    movieMapStore.setMode('edit')

    onBeforeMount(() => {
        editStore.appendImageField(1, true);
        editStore.appendImageField(1, false);
        editStore.appendImageField(2, true);
    })

    

    const imageFile = ref<File>()

  
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
            //return
        }
        editStore.postNewLocation()
    }
    

</script>
<template>
    <div class="sidebar-comp" >
        <div id="location-form">
            <h1>New Location</h1>
            <div>{{ editStore.newLocation }}</div>
            <div class="edit-row">
                <input type="text" v-model="editStore.newLocation.title" placeholder="title">
            </div>
            <div class="edit-row">
                <input type="number" min="-90" max="90"   :value="editStore.wrappedNewLocation.lat" @input="inputLatLng($event,'lat')" step="0.1">
                <input type="number"  :value="editStore.wrappedNewLocation.lng" @input="inputLatLng($event, 'lng')" step="0.1">
            </div>
            <div class="edit-row">
                <textarea v-model="editStore.newLocation.description" spellcheck="true" placeholder="description"></textarea>
            </div>

            <h2>Scene Images</h2>
            
            <ImageUploader v-for="(image,index) in editStore.sceneImages" @new-image="" :index="index" :type="1"/>

            <h2>Location Images</h2>

            <ImageUploader v-for="(image,index) in editStore.locationImages" @new-image="" :index="index" :type="2"/>

            
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