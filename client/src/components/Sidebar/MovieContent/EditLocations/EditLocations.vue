<script setup lang="ts">
    import ImageUploader from './ImageUploader.vue'
    import { useMovieMapStore } from '@/stores/MovieMap.store';
    import { useEditLocationStore } from '@/stores/EditLocation.store';
    import { ref, onBeforeMount, watch} from 'vue';
    import { useRoute } from 'vue-router';
    import { storeToRefs } from 'pinia';
    import {type locFormData} from "@/types/moviegeo.types"
    import { type apiStatus } from '@/types/types';
    import L from 'leaflet'
    const movieMapStore = useMovieMapStore()
    const editStore = useEditLocationStore()
    const route = useRoute();
    movieMapStore.setMode('edit')
    const blankLoc = { position: new L.LatLng(47.457809,-1.571045), title: '', description: '' }
    const {locFetchingStatus} = storeToRefs(movieMapStore)
    
    const setEditLocation = (id : number) => {
        if(!(id in movieMapStore.locations)) return
        const target = movieMapStore.locations[id]
        var editData : locFormData = {
            id: id,
            position: new L.LatLng(target.lat, target.lng),
            title: target.title,
            description: target.description
        }
        editStore.modifyingLocation = editData
    }

    const setBlankLocation = () => {
        
    }

    //route setup

    if(route.name == 'editLocation') {
        editStore.mode='edit';
    }
    else{
        editStore.mode = 'new'
    }
    console.log(route.params.edit_loc_id)
    onBeforeMount(() => {
        editStore.appendImageField(1, true);
        editStore.appendImageField(2, true);
    })

    watch(locFetchingStatus, (newStatus : apiStatus) => {
        if (newStatus == 'success'){
            if(editStore.mode == 'new') return
            setEditLocation(Number(route.params.edit_loc_id))
        }
    }, {immediate: true})
    
    //

    const imageFile = ref<File>()

  
    const inputLatLng = (e : Event, type: ('lat' | 'lng')) => {
        if(!e.target) return
        var val : number = Number((e.target as HTMLTextAreaElement).value)
        if(type == 'lat'){
            //val = Math.min(Math.max(val, -90), 90)
            editStore.modifyingLocation.position.lat = val
        }
        else{
            //val = Math.min(Math.max(val, -180), 180)
            editStore.modifyingLocation.position.lng = val
        }
    }

    const deleteImgObject = (type: (1|2), index : number) => {
        var imageGroup
        if(type==1) imageGroup = editStore.sceneImages 
        else imageGroup = editStore.locationImages
        console.log(index);
        console.log(imageGroup[index])
        imageGroup.splice(index,1)
        console.log(imageGroup)

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
            <div class="edit-row">
                <input type="text" v-model="editStore.modifyingLocation.title" placeholder="title">
            </div>
            <div class="edit-row" id="latlng-row">
                <input type="number" min="-90" max="90"   :value="editStore.wrappedNewLocation.lat" @input="inputLatLng($event,'lat')" step="0.1">
                <input type="number"  :value="editStore.wrappedNewLocation.lng" @input="inputLatLng($event, 'lng')" step="0.1">
            </div>
            <div class="edit-row">
                <textarea v-model="editStore.modifyingLocation.description" spellcheck="true" placeholder="description"></textarea>
            </div>

            <h2>Scene Images</h2>
            
            <ImageUploader v-for="(image,index) in editStore.sceneImages" :key="image.key" @new-image="" @delete="deleteImgObject(1, index)" :image-object="image" :index="index" :type="1"/>
            <div class="add-row">
                <button @click="editStore.appendImageField(1,false)">+</button>
            </div>
            <h2>Location Images</h2>

            <ImageUploader v-for="(image,index) in editStore.locationImages" :key="image.key" @new-image="" @delete="deleteImgObject(2, index)" :image-object="image" :index="index" :type="2"/>
            <div class="add-row">
                <button @click="editStore.appendImageField(2,false)">+</button>
            </div>
            <button @click="submit" > SUBMIT</button>
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

#latlng-row input {
    width: 8em;
    margin-right: 1em;
}

.edit-row {
    padding-bottom: 18px;
    display: flex;
    flex-direction: row;
}
.add-row{
    text-align: right;
}
</style>@/stores/EditLocation.store