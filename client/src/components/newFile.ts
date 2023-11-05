import { LMap, LTileLayer, LControlZoom, LMarker } from "@vue-leaflet/vue-leaflet";
import { onMounted, ref, type Ref } from 'vue';
import { useMovieMapStore } from "@/stores/MovieMap.store";
import { useEditLocationStore } from "@/stores/EditLocation.store";
import L, { type LatLngLiteral } from "leaflet";

export default (() => {
const __VLS_setup = async () => {
const movieMapStore = useMovieMapStore();
const editStore = useEditLocationStore();
const props = defineProps({
startzoom: Number
});

const zoom: Ref<number> = ref(props.startzoom || 4);

const map = ref<L.Map>();

const editMarker = ref<L.Marker>();
const editCoords = ref<L.LatLngLiteral>({ lat: editStore.selectedLocation.position.lat, lng: editStore.selectedLocation.position.lng });


const mapClick = (e: Event) => {
if ((movieMapStore.mode == 'edit') && 'latlng' in e) {
editStore.selectedLocation.position = e.latlng as LatLngLiteral;
}
};

const dragfunc = (e: Event) => {
//TODO: This function shouldn't be necessary, position not updating as expected on drag
if ((e.target) && ('_latlng' in e.target)) editStore.selectedLocation.position = e.target._latlng as LatLngLiteral;
};





onMounted(() => {


editStore.$subscribe((mutation, state) => {
console.log(typeof state.selectedLocation.position.lat, typeof state.selectedLocation.position.lng);
if (editMarker.value) {
var lat: number = state.selectedLocation.position.lat as number;
var lng: number = state.selectedLocation.position.lng as number;
editCoords.value = { lat, lng };
}
console.log(editCoords.value);
});

});
const __VLS_publicComponent = (await import('vue')).defineComponent({
props: ({
startzoom: Number
}),
setup() {
return {};
},
});

const __VLS_componentsOption = {};

let __VLS_name!: 'Map';
function __VLS_template() {
let __VLS_ctx!: InstanceType<import('./__VLS_types.js').PickNotAny<typeof __VLS_publicComponent, new () => {}>> & InstanceType<import('./__VLS_types.js').PickNotAny<typeof __VLS_internalComponent, new () => {}>> & {};
/* Components */
let __VLS_localComponents!: NonNullable<typeof __VLS_internalComponent extends { components: infer C; } ? C : {}> & typeof __VLS_componentsOption & typeof __VLS_ctx;
let __VLS_otherComponents!: typeof __VLS_localComponents & import('./__VLS_types.js').GlobalComponents;
let __VLS_own!: import('./__VLS_types.js').SelfComponent<typeof __VLS_name, typeof __VLS_internalComponent & typeof __VLS_publicComponent & (new () => { $slots: typeof __VLS_slots; }) >;
let __VLS_components!: typeof __VLS_otherComponents & Omit<typeof __VLS_own, keyof typeof __VLS_otherComponents>;
/* Style Scoped */
type __VLS_StyleScopedClasses = {};
let __VLS_styleScopedClasses!: __VLS_StyleScopedClasses | keyof __VLS_StyleScopedClasses | (keyof __VLS_StyleScopedClasses)[];
/* CSS variable injection */
/* CSS variable injection end */
let __VLS_templateComponents!: {} &
import('./__VLS_types.js').WithComponent<'LMap', typeof __VLS_components, 'LMap', 'lMap', 'l-map'> &
import('./__VLS_types.js').WithComponent<'LTileLayer', typeof __VLS_components, 'LTileLayer', 'lTileLayer', 'l-tile-layer'> &
import('./__VLS_types.js').WithComponent<'LMarker', typeof __VLS_components, 'LMarker', 'lMarker', 'l-marker'> &
import('./__VLS_types.js').WithComponent<'LControlZoom', typeof __VLS_components, 'LControlZoom', 'lControlZoom', 'l-control-zoom'>;
__VLS_components.LMap; __VLS_components.LMap; __VLS_components.lMap; __VLS_components.lMap; __VLS_components['l-map']; __VLS_components['l-map'];
// @ts-ignore
[LMap, LMap,];
__VLS_components.LTileLayer; __VLS_components.LTileLayer; __VLS_components.lTileLayer; __VLS_components.lTileLayer; __VLS_components['l-tile-layer']; __VLS_components['l-tile-layer'];
// @ts-ignore
[LTileLayer, LTileLayer,];
__VLS_components.LMarker; __VLS_components.lMarker; __VLS_components['l-marker'];
// @ts-ignore
[LMarker,];
__VLS_components.LControlZoom; __VLS_components.lControlZoom; __VLS_components['l-control-zoom'];
// @ts-ignore
[LControlZoom,];
{
({} as JSX.IntrinsicElements).div;
({} as JSX.IntrinsicElements).div;
(__VLS_x as JSX.IntrinsicElements)['div'] = { class: ("map-zone"), };
{
({} as JSX.IntrinsicElements).div;
({} as JSX.IntrinsicElements).div;
(__VLS_x as JSX.IntrinsicElements)['div'] = { style: ({}), };
{
__VLS_templateComponents.LMap;
(__VLS_x as import('./__VLS_types.js').ComponentProps<typeof __VLS_templateComponents.LMap>) = { ref: ("map"), zoom: ((__VLS_ctx.zoom)), useGlobalLeaflet: ((false)), 'use-global-leaflet': ((false)), center: (([47.41322, -1.219482])), options: (({ zoomControl: false, minZoom: 2 })), };
// @ts-ignore
(__VLS_ctx.map);
// @ts-ignore
[zoom, map,];
const __VLS_0 = new __VLS_templateComponents.LMap({ ref: ("map"), zoom: ((__VLS_ctx.zoom)), useGlobalLeaflet: ((false)), 'use-global-leaflet': ((false)), center: (([47.41322, -1.219482])), options: (({ zoomControl: false, minZoom: 2 })), });
const __VLS_1 = __VLS_templateComponents.LMap({ ref: ("map"), zoom: ((__VLS_ctx.zoom)), useGlobalLeaflet: ((false)), 'use-global-leaflet': ((false)), center: (([47.41322, -1.219482])), options: (({ zoomControl: false, minZoom: 2 })), });
let __VLS_2!: import('./__VLS_types.js').PickNotAny<typeof __VLS_0, typeof __VLS_1>;
type __VLS_3 = import('./__VLS_types.js').InstanceProps<typeof __VLS_2, typeof __VLS_templateComponents.LMap>;
const __VLS_4: import('./__VLS_types.js').EventObject<typeof __VLS_2, 'click', typeof __VLS_templateComponents.LMap, __VLS_3['onClick']> = {
click: (__VLS_ctx.mapClick)
};
// @ts-ignore
[zoom, zoom, mapClick,];
{
__VLS_templateComponents.LTileLayer;
(__VLS_x as import('./__VLS_types.js').ComponentProps<typeof __VLS_templateComponents.LTileLayer>) = { url: ("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"), layerType: ("base"), 'layer-type': ("base"), name: ("OpenStreetMap"), };
}
if (__VLS_ctx.movieMapStore.mode == 'edit') {
// @ts-ignore
[movieMapStore,];
{
(__VLS_x as import('./__VLS_types.js').ComponentProps<typeof __VLS_templateComponents.LMarker>) = { ref: ("editMarker"), draggable: ((true)), latLng: ((__VLS_ctx.editStore.selectedLocation.position as L.LatLngLiteral)), 'lat-lng': ((__VLS_ctx.editStore.selectedLocation.position as L.LatLngLiteral)), };
// @ts-ignore
(__VLS_ctx.editMarker);
// @ts-ignore
[editStore, editMarker,];
const __VLS_5 = new __VLS_templateComponents.LMarker({ ref: ("editMarker"), draggable: ((true)), latLng: ((__VLS_ctx.editStore.selectedLocation.position as L.LatLngLiteral)), 'lat-lng': ((__VLS_ctx.editStore.selectedLocation.position as L.LatLngLiteral)), });
const __VLS_6 = __VLS_templateComponents.LMarker({ ref: ("editMarker"), draggable: ((true)), latLng: ((__VLS_ctx.editStore.selectedLocation.position as L.LatLngLiteral)), 'lat-lng': ((__VLS_ctx.editStore.selectedLocation.position as L.LatLngLiteral)), });
let __VLS_7!: import('./__VLS_types.js').PickNotAny<typeof __VLS_5, typeof __VLS_6>;
type __VLS_8 = import('./__VLS_types.js').InstanceProps<typeof __VLS_7, typeof __VLS_templateComponents.LMarker>;
const __VLS_9: import('./__VLS_types.js').EventObject<typeof __VLS_7, 'dragend', typeof __VLS_templateComponents.LMarker, __VLS_8['onDragend']> = {
dragend: (__VLS_ctx.dragfunc)
};
// @ts-ignore
[editStore, editStore, dragfunc,];
}
}
{
(__VLS_x as import('./__VLS_types.js').ComponentProps<typeof __VLS_templateComponents.LControlZoom>) = { position: ("bottomright"), zoomInText: ("+"), 'zoom-in-text': ("+"), zoomOutText: ("-"), 'zoom-out-text': ("-"), };
}
}
}
}
if (typeof __VLS_styleScopedClasses === 'object' && !Array.isArray(__VLS_styleScopedClasses)) {
}
declare var __VLS_slots: {};
return __VLS_slots;
}
const __VLS_internalComponent = (await import('vue')).defineComponent({
setup() {
return {
LMap: LMap,
LTileLayer: LTileLayer,
LControlZoom: LControlZoom,
LMarker: LMarker,
movieMapStore: movieMapStore,
editStore: editStore,
zoom: zoom,
map: map,
editMarker: editMarker,
mapClick: mapClick,
dragfunc: dragfunc,
};
},
});
return {} as typeof __VLS_publicComponent;
};
return {} as typeof __VLS_setup extends () => Promise<infer T> ? T : never;
})({} as any);
