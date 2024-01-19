<script setup lang="ts">
    import ImageUploader from './ImageUploader.vue'
    import { useMovieMapStore } from '@/stores/MovieMap.store';
    import { useEditLocationStore } from '@/stores/EditLocation.store';
    import {type imageObject } from "@/interfaces/edit.int"

    import { ref, onBeforeMount, watch, computed} from 'vue';
    import { useRoute } from 'vue-router';
    import { storeToRefs } from 'pinia';
    import {type locFormData} from "@/types/moviegeo.types"
    import { type apiStatus } from '@/types/types'
    import { type Location } from "@/types/moviegeo.types"
    import movieGeoService from '@/api/movieGeoService';
    import L from 'leaflet'
    const movieMapStore = useMovieMapStore()
    const editStore = useEditLocationStore()
    const route = useRoute();
    movieMapStore.setMode('edit')
    const blankLoc = { position: new L.LatLng(47.457809,-1.571045), title: '', scene_desc: '' }
    const {locFetchingStatus} = storeToRefs(movieMapStore)
    const {waiting} = storeToRefs(editStore)
    

    const changed = computed<boolean>(() => {
        return true
    })

    
    const setEditLocation = (id : number) => {
        if(!(id in movieMapStore.locations)) return
        waiting.value = false
        const target = movieMapStore.locations[id]
        var editData : locFormData = {
            id: id,
            position: new L.LatLng(target.lat, target.lng),
            title: target.title,
            scene_desc: target.scene_desc,
            location_desc: target.location_desc
        }
        editStore.locOriginalVals = target;
        editStore.modifyingLocation = editData
        movieGeoService.fetchLocationImages(Number(id)).then((data : any) => {
            (data.data as imageObject[]).forEach((el : any) => {
                el.status = 'update'
            });
            editStore.sceneImages = data.data.filter((img : any) => img.type==1)
            editStore.locationImages = data.data.filter((img : any) => img.type==2)
        })
        .catch((error : Error) => {
            console.log(error)
        })
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
    //console.log(route.params.edit_loc_id)
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

    const revertLoc = () => {
        if(!editStore.locOriginalVals) return
        editStore.modifyingLocation.position.lat = editStore.locOriginalVals.lat
        editStore.modifyingLocation.position.lng = editStore.locOriginalVals.lng

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

    const submitNew = () => {
        console.log('submit')
        waiting.value=true
        editStore.postNewLocation().finally(() => {
            waiting.value = false
        })
    }

    const submitUpdate = () => {
        console.log('update')
        waiting.value = true
        editStore.postUpdateLocation().finally(() => {
            waiting.value = false
        })
    }
    

</script>
<template>
    <div class="sidebar-comp" >
        <div id="location-form">
            <h1>New Location</h1>
            <div class="edit-row">
                <div>
                    <label for="title">Title</label>
                    <input type="text" name="title" v-model="editStore.modifyingLocation.title" placeholder="title" :disabled="waiting">
                </div>
            </div>
            <div class="edit-row" id="latlng-row" >
                <div>
                    <label for="latitude">Latitude</label>
                    <input name="latitude" type="number" min="-90" max="90"   :value="editStore.wrappedNewLocation.lat" @input="inputLatLng($event,'lat')" step="0.1" :disabled="waiting">
                </div>
                <div>
                    <label for="longitude">Longitude</label>
                    <input name="longitude" type="number"  :value="editStore.wrappedNewLocation.lng" @input="inputLatLng($event, 'lng')" step="0.1" :disabled="waiting">
                </div>
                <div>
                    <input name="revert-coordinates" type="button" value="revert" @click="revertLoc" v-if="editStore.mode=='edit'" :disabled="waiting">
                </div>
            </div>
            <div class="edit-row">
                <div>
                    <label for="scene-description">Scene Description</label>
                    <textarea name="scene-description" v-model="editStore.modifyingLocation.scene_desc" spellcheck="true" placeholder="Scene Description" :disabled="waiting"></textarea>
                </div>
            </div>
            <div class="edit-row">
                <div>
                    <label for="location-description">Location Description</label>
                    <textarea name="location-description" v-model="editStore.modifyingLocation.location_desc" spellcheck="true" placeholder="Location Description" :disabled="waiting"></textarea>
                </div>
            </div>
            <div class="edit-row">
                <div>
                    <label for="streetview-url">Google Steetview Embed URL</label>
                    <input name="streetview-url" type="text" placeholder="URL" spellcheck="false"/>
                </div> 
            </div>
            <h2>Scene Images</h2>
            
            <ImageUploader v-for="(image,index) in editStore.sceneImages" :key="image.key" @new-image="" @delete="deleteImgObject(1, index)" :image-object="image" :index="index" :type="1"/>
            <div class="add-row">
                <button @click="editStore.appendImageField(1,false)" :disabled="waiting">+</button>
            </div>
            <h2>Location Images</h2>

            <ImageUploader v-for="(image,index) in editStore.locationImages" :key="image.key" @new-image="" @delete="deleteImgObject(2, index)" :image-object="image" :index="index" :type="2"/>
            <div class="add-row">
                <button @click="editStore.appendImageField(2,false)" :disabled="waiting">+</button>
            </div>
            <button @click="submitNew" v-if="editStore.mode=='new'" :disabled="waiting">SUBMIT</button>
            <button @click="submitUpdate" v-if="editStore.mode=='edit'" :disabled="waiting">SAVE CHANGES</button>

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

.edit-row div {
    display: flex;
    flex-direction: column;
    justify-content: flex-end;
    width:100%;
}


.add-row{
    text-align: right;
}
</style>@/stores/EditLocation.store