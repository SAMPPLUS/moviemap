<script setup lang="ts">
    import ImageUploader from './ImageUploader.vue'
    import { useMovieMapStore } from '@/stores/MovieMap.store'
    import { useEditLocationStore } from '@/stores/EditLocation.store'
    import {type imageObject } from "@/interfaces/edit.int"

    import { ref, onBeforeMount, watch, computed} from 'vue'
    import { useRoute } from 'vue-router'
    import { storeToRefs } from 'pinia'
    import {type locFormData} from "@/types/moviegeo.types"
    import { type apiStatus } from '@/types/types'
    import { type Location } from "@/types/moviegeo.types"
    import movieGeoService from '@/api/movieGeoService'
    import L from 'leaflet'
    import {XMLParser, } from 'fast-xml-parser';

    import { NomReverseGeocode } from '@/api/geocode'
import type { AxiosResponse } from 'axios'
import { parse } from 'path';

    const movieMapStore = useMovieMapStore()
    const editStore = useEditLocationStore()
    const route = useRoute();
    movieMapStore.setMode('edit')
    const blankLoc = { position: new L.LatLng(47.457809,-1.571045), title: '', scene_desc: '' }
    const {locFetchingStatus} = storeToRefs(movieMapStore)
    const {waiting} = storeToRefs(editStore)
    const parser = new XMLParser();

    const hide_address = ref<boolean>(false)

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
            location_name: target.location_name,
            location_desc: target.location_desc,
            g_streetview_embed_url: target.g_streetview_embed_url,
            street: target?.street,
            city: target?.city,
            region: target?.region,
            country: target?.country,
            zip: target?.zip,
            specificity: target.specificity
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

    const geoCodeReverse = async () => {
        NomReverseGeocode(editStore.wrappedNewLocation.lat, editStore.wrappedNewLocation.lng)
        .then((response : AxiosResponse) => {
            if(response.status != 200) return
            const data = response.data
            if(data.features){
                var parts = data.features[0].properties.geocoding
                console.log(parts)
                console.log(parts.label)
                const street_part_order =['housenumber', 'street', 'locality', 'district']
                var street = ""
                street_part_order.forEach((part) => {
                    if(parts[part]) street += parts[part] + ', '
                })
                if(street.length>=2 && street[street.length-2] == ',')  street = street.slice(0, street.length-2)

                editStore.modifyingLocation.street = street
                editStore.modifyingLocation.location_name = parts.name
                editStore.modifyingLocation.city = parts.city
                editStore.modifyingLocation.zip = parts.postcode
                editStore.modifyingLocation.region = parts.state
                editStore.modifyingLocation.country = parts.country_code.toUpperCase()
            }
        })
        .catch((error : Error) => {
            console.log(error)
        })
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
            <h1>Edit Location</h1>
            <div class="edit-row">
                <div>
                    <label for="title">Scene Title</label>
                    <input type="text" name="title" v-model="editStore.modifyingLocation.title" placeholder="title" :disabled="waiting">
                </div>
            </div>
            <div class="edit-row">
                <div>
                    <label for="scene-description">Scene Description</label>
                    <textarea name="scene-description" v-model="editStore.modifyingLocation.scene_desc" spellcheck="true" placeholder="Scene Description" :disabled="waiting"></textarea>
                </div>
            </div>
            <hr>
            
            <div class="edit-row" id="latlng-row" >
                <div>
                    <label for="latitude">Latitude</label>
                    <input name="latitude" type="number" min="-90" max="90"   :value="editStore.wrappedNewLocation.lat" @input="inputLatLng($event,'lat')" step="0.1" :disabled="waiting">
                </div>
                <div>
                    <label for="longitude">Longitude</label>
                    <input name="longitude" type="number"  :value="editStore.wrappedNewLocation.lng" @input="inputLatLng($event, 'lng')" step="0.1" :disabled="waiting">
                </div>
                <div style="display: flex; flex-direction: row; align-items: end; width: fit-content;">
                    <button class="icon-btn" name="revert-coordinates" @click="geoCodeReverse" v-if="editStore.mode=='edit'" :disabled="waiting">
                        <img  src="@/assets/icons/search.svg"/>
                    </button>
                    <button class="icon-btn" name="revert-coordinates" @click="revertLoc" v-if="editStore.mode=='edit'" :disabled="waiting">
                        <img  src="@/assets/icons/undo.svg"/>
                    </button>
                </div>
            </div>
            <div class="edit-row">
                <div>
                    <label for="loc-name">Location Name</label>
                    <input type="text" name="loc-name" v-model="editStore.modifyingLocation.location_name" placeholder="Name" :disabled="waiting">
                </div>
                <div class="hide-div"></div>
            </div>
            <div class="edit-row" style="justify-content: flex-end; padding-bottom: 0;">
                <label for="show-address" style="font-size: .8rem;" >hide address details  </label>
                <div class="hide-div">
                    <input name="show-address" style="margin-bottom: 4px" type="checkbox"  v-model="hide_address" :disabled="waiting">
                </div>
            </div>
            <div class="edit-row">
                <div>
                    <textarea rows="2" style="resize: vertical;" v-model="editStore.modifyingLocation.street" placeholder="Street" :disabled="waiting || hide_address"></textarea>
                </div>
                <div class="hide-div">
                    <input name="show-address" type="checkbox" value="true" :disabled="waiting">
                </div>
            </div>
            <div class="edit-row">
                <div>
                    <input placeholder="City" v-model="editStore.modifyingLocation.city" :disabled="waiting || hide_address"> 
                </div>
                <div>
                    <input placeholder="Region/State" v-model="editStore.modifyingLocation.region" :disabled="waiting || hide_address">
                </div>
                <div class="hide-div">
                    <input name="show-address" type="checkbox" value="true" :disabled="waiting">
                </div>
            </div>
            <div class="edit-row">
                <div>
                    <input placeholder="Country" v-model="editStore.modifyingLocation.country" :disabled="waiting || hide_address">
                </div>
                <div>
                    <input placeholder="Postal Code" v-model="editStore.modifyingLocation.zip" :disabled="waiting || hide_address">
                </div>
                <div class="hide-div"></div>
            </div>
            <div class="edit-row">
                <div>
                    <label for="location-description">Location Description</label>
                    <textarea class="desc"  name="location-description" v-model="editStore.modifyingLocation.location_desc" spellcheck="true" placeholder="Location Description" :disabled="waiting"></textarea>
                </div>
            </div>
            <div class="edit-row">
                <div>
                    <label for="streetview-url">Google Steetview Embed URL</label>
                    <input name="streetview-url" v-model="editStore.modifyingLocation.g_streetview_embed_url" type="text" placeholder="URL" spellcheck="false"/>
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

textarea { resize: vertical;}

#location-form {
    padding: 0 30px 0 30px;
}

#location-form input {
    font-size: 18px;
}

.desc {
    font-size: 18px;
    width: 100%;
    height: 8em;
    resize: vertical;
}

#latlng-row input {
    width: 8em;
    margin-right: 1em;
}

label { line-height: 1.25;}

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

.hide-div {
    width:50px !important;
    min-width: 50px;
    padding-bottom: 5px;
}
.add-row{
    text-align: right;
}

.icon-btn {
    width: fit-content;
    height: fit-content;
    margin-right: 3px;
}
</style>