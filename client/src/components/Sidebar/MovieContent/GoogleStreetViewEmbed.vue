<script setup lang="ts">
const props = defineProps({url: String})


</script>

<template>
    <div class="streetview-container">
        <div class="h_iframe" v-if="props.url">
            <iframe :src="props.url" style="border:0;" allowfullscreen loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
        </div>
    </div>
</template>

<style>
.streetview-container {
}

.h_iframe iframe {
    width:100%;
    height:100%;
}
.h_iframe {
    height: 400px;
    width:100%;
    padding-right: 12%;
    padding-left: 12%;

}
</style>