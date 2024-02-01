<script setup lang="ts">
import { useToastStore } from '@/stores/Toast.store';
import { ref } from 'vue';
const store = useToastStore()
const hover = ref<boolean>(false);
</script>

<template>
    <Teleport to="body">
        <Transition name="toast-fade">
            <div class="toast-outer"
                v-if="(store.show && store.text) || hover"
                @click.self=""
                @mouseover="hover = true"
                @mouseleave="hover = false">
              
              <div :class="['toast-body', store.type? store.type : 'neutral']">
                {{ store.text }}
              </div>
            </div>
        </Transition>
    </Teleport>
</template>

<style scoped>

.toast-fade-enter-from,
.toast-fade-leave-to {
  opacity: 0;
}

.toast-fade-enter-active
 {
  transition: 0.25s ease all;
}

.toast-fade-leave-active {
  transition: 1s ease all;
}

.toast-outer {
    position: fixed;
    z-index: 501;
    bottom: 0;
    width: 100%;
    display: flex;
    flex-direction: row;
    justify-content: center;
}

.toast-body {
    max-width: 45vw;
    min-width: 300px;
    margin-bottom: 16px;
    padding: 6px 32px;
    border-radius: 8px;
    text-align: center;
    font-size: 1rem;
    font-weight: 600;
    border: 2px solid white;
}

.toast-body.neutral {
    background: rgb(138, 138, 138);
    border-color: rgb(50, 50, 50);
}

.toast-body.success {
    background: #72AE95;
}

.toast-body.warning {
    background: #f7b527;
}

.toast-body.error {
    background-color: #f84919;
}


</style>