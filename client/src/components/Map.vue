<script setup lang="ts">
  import "leaflet/dist/leaflet.css";
  import { LMap, LTileLayer, LControlZoom, LMarker, LTooltip } from "@vue-leaflet/vue-leaflet";
  import { onMounted, computed, ref, type Ref, watch } from 'vue';
  import { useMovieMapStore } from "@/stores/MovieMap.store";
  import { useEditLocationStore } from "@/stores/EditLocation.store"
  import L, { type LatLngExpression, type LatLngLiteral, LatLngBounds, type PointExpression } from "leaflet"
  const props  = defineProps({
  startzoom: Number
  })

  const center : Ref<PointExpression> = ref([32.842, -37.089])
  const map = ref<typeof LMap>()
  const mapBounds = ref<LatLngBounds>()

  const movieMapStore = useMovieMapStore()
  const editStore = useEditLocationStore()
  const zoom : Ref<number> = ref(props.startzoom || 4)
  
  const mapClick = (e : Event) => {
    if((movieMapStore.mode == 'edit') && 'latlng' in e){
      editStore.selectedLocation.position = e.latlng as LatLngLiteral
    }

  }
  const dragEndEditMarker = (e: Event) => {
    //TODO: This function shouldn't be necessary, position not updating as expected on drag
    if((e.target) && ('_latlng' in e.target)) editStore.selectedLocation.position = e.target._latlng as LatLngLiteral
  }

  const pauseThenZoomBounds = async () => {
    setTimeout(() => {
                  if(map.value && (movieMapStore.selectedLocationIdx==undefined)) map.value.leafletObject.flyToBounds((movieMapStore.locations as { lat: number, lng: number }[]).map(i => [i.lat,i.lng]), {duration: 1})
                },1000)
  }

  const clickLocationMarker = (idx : number) => {
    //movieMapStore
  }

  movieMapStore.$onAction(
        ({
          name, // name of the action
          store, // store instance, same as `someStore`
          args, // array of parameters passed to the action
          after, // hook after the action returns or resolves
          onError, // hook if the action throws or rejects
        }) => {
          if(name=='fetchMovieDetails'){
            after(() =>{
                pauseThenZoomBounds()          
            })
          }
          if(name=='setSelectedLocationIdx'){
            if(args[0] != undefined){
              var l = movieMapStore.locations[args[0]]
              map.value?.leafletObject.setView([l.lat, l.lng], 13, {animate: true})
            }
            
          }
        })

  
</script>

<template>
  <div class="map-zone">
    <div style="height:100vh; ">
      <l-map ref="map" v-model:zoom="zoom" @click="mapClick"  :use-global-leaflet="false" :center="center"  :options="{zoomControl: false, minZoom: 2}">
        <l-tile-layer
          url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
          layer-type="base"
          name="OpenStreetMap"
        ></l-tile-layer>
        <l-marker
            id="editMarker"
            @dragend="dragEndEditMarker"
            :draggable="true"
            :lat-lng="[editStore.selectedLocation.position.lat, editStore.selectedLocation.position.lng]" 
            v-if="movieMapStore.mode == 'edit'"
          />
        <l-marker
          v-for="(location, index) in movieMapStore.locations"
          :key="location.id"
          :lat-lng="[location.lat,location.lng]"
          :draggable="false"
          @click="movieMapStore.setSelectedLocationIdx(index)"
        >
          <l-tooltip :options="{opacity: 1}"><img class="tt-image" :src="(location.main_img_path) || (movieMapStore.placeholderStill)"></l-tooltip>
        </l-marker>
        <l-control-zoom position="bottomright" zoom-in-text="+" zoom-out-text="-" />
      </l-map>
    </div>
  </div>
</template> 
<style>
.map-zone {
  width: 100%;
}
.tt-image {
  max-width: 200px;
}
</style>