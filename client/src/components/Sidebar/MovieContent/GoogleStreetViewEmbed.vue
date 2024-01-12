<script setup lang="ts">
const props = defineProps({url: String})


</script>

<template>
    <div class="h_iframe" v-if="props.url">
        <iframe :src="props.url" style="border:0;" allowfullscreen loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
    </div>
</template>

<style>
.h_iframe iframe {
    width:100%;
    height:100%;
}
.h_iframe {
    height: 500px;
    width:100%;
    padding: 0 25px 0 25px;
}
</style>