<script setup lang="ts"></script>

<template>
<div class="scene-selector">
    <div class="scroller">
        <div class="end"></div>
        <div class="card" v-for="n in 10">

        </div>
        <div class="end"></div>
    </div>
</div>
</template>

<style>
.scene-selector {
    outline: 1px solid rgb(24, 24, 24);
    height: 100%;
    background: rgb(0, 0, 0);
    overflow-x: scroll;
    scrollbar-color: white;
}
.scroller {
    height: 100%;
    background: rgb(0, 0, 0);
    display: flex;
    flex-direction: row;
    scrollbar-color: white;
}

.end {
    min-width: 50px;
}

.card {
    margin: 10px 5px 10px 5px;
    height: 140px;
    aspect-ratio: 16 / 9;
    background: rgb(86, 86, 86);
    border-radius: 5px;
}
</style>