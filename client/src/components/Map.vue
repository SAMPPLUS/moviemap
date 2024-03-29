<script setup lang="ts">
  import "leaflet/dist/leaflet.css";
  import { setMapStoreSuffix, storeToRefs } from "pinia";
  import { LMap, LTileLayer, LControlZoom, LMarker, LTooltip, LControl } from "@vue-leaflet/vue-leaflet";
  import { onMounted, computed, shallowRef, ref, type Ref, watch } from 'vue';
  import { useMovieMapStore } from "@/stores/MovieMap.store";
  import { useEditLocationStore } from "@/stores/EditLocation.store.js"
  import L, { type LatLngExpression, type LatLngLiteral, LatLngBounds, type PointExpression } from "leaflet"
  import { type Location } from "@/types/moviegeo.types";
  import { IMG_PATH } from "@/util/const";
  import Image from "./Util/Image.vue";
  import MovieCard from "./Util/MovieCard.vue";
  import { useCurrentUser } from "vuefire";
  import { useUserStore } from "@/stores/User.store";

  const props  = defineProps({
  startzoom: Number
  })

  const center : Ref<PointExpression> = ref([32.842, -37.089])
  const map = ref<typeof LMap>()
  const userStore = useUserStore();

  const {user} = storeToRefs(userStore)


  type mapActionType = ('zoomtobounds' | 'zoomtoloc')
  interface mapQueuedAction {type: mapActionType; params? : any[]}
  const mapQueuedAction= ref<undefined | mapQueuedAction>()
  const isMapReady = ref<boolean>(map.value ? true : false)
  const mapBounds = ref<LatLngBounds>()

  const movieMapStore = useMovieMapStore()
  const editStore = useEditLocationStore()
  const zoom : Ref<number> = ref(props.startzoom || 4)

  const modifyingId = ref(editStore.modifyingLocation.id)

  const {locations, selectedLocationIdx, mode} = storeToRefs(movieMapStore)

  const icon  = new  L.Icon.Default()
  icon.options.iconSize = [50,82]
  icon.options.iconAnchor = [26, 81]

  const editIcon = ref<L.Icon>(icon as L.Icon)


  
  const startActionSubscribe = () => {

  }

  const mapReady = (e: Event) => {
    isMapReady.value = true
    if(!mapQueuedAction.value) return
    if(mapQueuedAction.value.type = 'zoomtoloc'){
      if( !mapQueuedAction.value.params) return
      ZoomToLoc(mapQueuedAction.value.params[0])
    }
    console.log(mapQueuedAction.value)
  }
  
  const mapClick = (e : Event) => {
    if((movieMapStore.mode == 'edit') && 'latlng' in e){
      editStore.modifyingLocation.position = e.latlng as L.LatLng
    }

  }
  const editMarker = (e: Event) => {
    //TODO: This function shouldn't be necessary, position not updating as expected on drag
    if((e.target) && ('_latlng' in e.target)) editStore.modifyingLocation.position = e.target._latlng as L.LatLng
  }

  const ZoomToBounds = async () => {
    if(!map.value) return
    if(Object.keys(movieMapStore.locations).length < 1) return
    map.value.leafletObject.flyToBounds(
      (Object.values(movieMapStore.locations) as { lat: number, lng: number }[]).map(i => [i.lat,i.lng]), {duration: 1, padding: [70,70]}) 
  }

  const ZoomToLoc = (l : {lat: number, lng : number}) => {
    if(!map.value || !isMapReady.value) return
    map.value.leafletObject.setView([l.lat, l.lng], 15, {animate: true, duration: 1})
  }

  const clickLocationMarker = (id : number) => {
    movieMapStore.setSelectedLocationId(id)
  }


  const setQueuedMapAction = (action : mapQueuedAction) => {
    mapQueuedAction.value = action
  }

  const notEditing = ref((location: Location) => {
    if((movieMapStore.mode !='edit' || !editStore.modifyingLocation.id)) return true
    return editStore.modifyingLocation.id != Number(location.id)
  })



  watch(locations, (newLocations, oldLocations) => {
    if(Object.keys(newLocations).length==0) return
    if(map.value && isMapReady.value) ZoomToBounds()
    else{
      setQueuedMapAction({type: 'zoomtobounds'})
    }
  })

  watch(selectedLocationIdx, (newIdx, oldIdx) => {
    if((typeof newIdx == 'undefined') || newIdx < 0) return
    var l = movieMapStore.locations[newIdx as number]
    if(isMapReady.value && map.value){
      ZoomToLoc(l)
    }
    else{
      setQueuedMapAction({type: 'zoomtoloc', params: [l]})
    }
  })

  const getSceneImgPath = (location : Location) => {
    if(location.scene_img){
        return IMG_PATH + location.scene_img
    }
    else return (location.main_img_path) || (movieMapStore.placeholderStill)
  }

  movieMapStore.$onAction(
        ({
          name, // name of the action
          store, // store instance, same as `someStore`
          args, // array of parameters passed to the action
          after, // hook after the action returns or resolves
          onError, // hook if the action throws or rejects
        }) => {
          // if(name=='fetchMovieDetails'){
          //   after(() =>{
          //       pauseThenZoomBounds()          
          //   })
          // }
          if(name=='setSelectedLocationId'){
            if(args[0] != undefined){
              var l = movieMapStore.locations[args[0]]
              if(isMapReady.value && map.value){
                map.value.leafletObject.setView([l.lat, l.lng], 15, {animate: true})
              }
              else{
                //mapQueuedAction.value = {func: 'setView', params: [l]}
              }
            }
          }
        })



  
</script>

<template>
  <div class="map-zone">
    <div style="height:100vh; ">
      <l-map ref="map" style="z-index: 0;" v-model:zoom="zoom" @click="mapClick" @ready="mapReady"  :use-global-leaflet="false" :center="center"  :options="{zoomControl: false, minZoom: 2, worldCopyJump: true}">
        <l-tile-layer
          url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
          layer-type="base"
          name="OpenStreetMap"
        ></l-tile-layer>
        <l-marker
            id="editMarker"
            @dragend="editMarker"
            :draggable="true"
            :lat-lng="[editStore.modifyingLocation.position.lat, editStore.modifyingLocation.position.lng]" 
            v-if="movieMapStore.mode == 'edit'"
            :options="{icon: editIcon}"
          />
        <div class="markers"  v-for="(location, id) in movieMapStore.locations">
          <div class="marker-group"  >
            <l-marker
              :key="id"
              :lat-lng="[location.lat,location.lng]"
              :draggable="false"
              :visible="notEditing(location)"
              @click="clickLocationMarker(id)"
            >
              <l-tooltip :options="{opacity: 1}"><img class="tt-image" :src="getSceneImgPath(location)"></l-tooltip>
            </l-marker>
            <l-marker
              
              :key="id"
              :lat-lng="[location.lat,location.lng-360]"
              :draggable="false"
              :visible="notEditing(location)"

              @click="clickLocationMarker(id)"
            >
              <l-tooltip :options="{opacity: 1}"><img class="tt-image" :src="getSceneImgPath(location)"></l-tooltip>
            </l-marker>
            <l-marker
              :key="id"
              :lat-lng="[location.lat,location.lng+360]"
              :draggable="false"
              :visible="notEditing(location)"

              @click="clickLocationMarker(id)"
              >
              <l-tooltip :options="{opacity: 1}"><img class="tt-image" :src="getSceneImgPath(location)"></l-tooltip>
            </l-marker>
          </div>
        </div>
        <l-control-zoom position="bottomright" zoom-in-text="+" zoom-out-text="-" />
        <l-control position="bottomright" class="map-control">
          <button href="#" class="map-control-btn" @click="ZoomToBounds"> 
            <img alt="Vue logo" class="logo" src="@/assets/icons/position.svg" width="24" height="24" />
          </button>
        </l-control>
      </l-map>
    </div>
    <div class="overlay" id="overlay-nowshowing" v-if="movieMapStore.filmDetails" v-show="false">
        <MovieCard :film-details="movieMapStore.filmDetails"/>
    </div>
    <div v-if="userStore.user" class="overlay" id="overlay-adminlogin">
      <div>Logged In</div>
      <div>
        {{userStore.user.email}}
      </div>
    </div>
  </div>
</template> 
<style scoped>

.overlay {
  position: absolute;
  z-index: 2;

}

#overlay-nowshowing {
  width: 400px;
  left: 0;

  top: 0;
  margin: 0 auto;
  pointer-events: auto;
}

#overlay-adminlogin {
  width: 100px;
  right: 0;
  top: 0;
  margin: 0 auto;
  pointer-events: auto;
  background-color: rgba(0, 0, 0, 0.199);
  font-size: .8rem;
  text-align: center;
  overflow: hidden;
}
.map-control {
  border: 2px solid rgb(164, 164, 164);
  border-radius: 4px;
}
.map-control-btn {
  width: 30px;
  height:30px;
  border: 0;
  background-color: white;
  padding:  1px;
  cursor: pointer;
}



.map-control-btn:hover {
  background-color: rgb(245, 245, 245);
}
.map-zone {
  width: 100%;
  height: 100%;
  background-color: white;
  z-index: 14;
  position: relative;
  overflow: hidden;
}
.tt-image {
  max-width: 13vw;
}
</style>