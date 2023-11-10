<script setup lang="ts">
import { useMovieMapStore } from '@/stores/MovieMap.store'
const movieMapStore = useMovieMapStore()


</script>
<template>
    <div>
        <div>
            location details
        </div>

        {{ movieMapStore.selectedLocation }}
    </div>
</template>
<style></style>