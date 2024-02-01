<script setup lang="ts">
import { type PropType } from "vue";
import { type Locations } from "@/types/moviegeo.types";
import Image from "@/components/Util/Image.vue";
import { useMovieMapStore } from "@/stores/MovieMap.store";

const store = useMovieMapStore();

defineProps({
    locations: {
        type: Object as PropType<Locations>
    }
})

const clickOption = (e: Event, id : number) => {
    store.setSelectedLocationId(id)
}

</script>

<template>
    <div class="loc-list-container">
        <div class="loc-card" v-for="loc in locations">
            <a class="loc-card-details" href="#" @click="clickOption($event, Number(loc.id))">
                <div class="img-container">
                    <Image style="height: 100%; border-radius: 8px;" :src="loc.scene_img" :caption="loc.scene_img_desc"/>
                </div>
                <div class="name">
                    <h3>{{ loc.title }}</h3>
                </div>
            </a>
            <hr style="margin: 0 3px; border-color: rgb(119, 119, 119);">
        </div>
    </div>
</template>

<style scoped>

.loc-card {
    height: 110px;
}
.loc-card-details {
    display: flex;
    flex-direction: row;
    height: 100%;
}

.loc-card-details .img-container {
    padding: 8px;
    height: 100%;
}

.loc-card-details .name {
    padding-left: 6px;
    color: whitesmoke;
    display: flex;
    flex-direction: column;
    justify-content: center;
}
</style>