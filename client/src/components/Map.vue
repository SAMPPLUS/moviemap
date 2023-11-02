<template>
    <div style="height:100vh;width:800px">
      <l-map ref="map" v-model:zoom="zoom" :use-global-leaflet="false" :center="[47.41322, -1.219482]" :options="{zoomControl: false, minZoom: 2}">
        <l-tile-layer
          url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
          layer-type="base"
          name="OpenStreetMap"
        ></l-tile-layer>
        <l-control-zoom position="bottomright" zoom-in-text="+" zoom-out-text="-" />
      </l-map>
    </div>
  </template>
  
  <script setup lang="ts">
  import "leaflet/dist/leaflet.css";
  import {ref} from 'vue';
  import { LMap, LTileLayer, LControlZoom } from "@vue-leaflet/vue-leaflet";
  
  const zoom = ref(2)
  </script>
  