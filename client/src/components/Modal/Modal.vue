<script setup lang="ts">
import { useModalStore } from '@/stores/Modal.store';

const store = useModalStore();</script>

<template>
    <Teleport to="body">
        <Transition name="modal-fade">
            <div class="modal-wrapper"
            v-if="store.component"
            @click.self="store.closeModal">
              <div class="modal">
                <component :is="store.component"
                v-bind="store.props"
                />
              </div>
            </div>
        </Transition>
    </Teleport>
</template>

<style >
.modal-fade-enter-from,
.modal-fade-leave-to {
  opacity: 0;
}

.modal-fade-enter-active,
.modal-fade-leave-active {
  transition: 0.25s ease all;
}

.modal-wrapper {
  position: fixed;
  left: 0;
  top: 0;

  z-index: 500;

  width: 100vw;
  height: 100vh;

  background: rgba(0, 0, 0, 0.4);

  display: grid;
  place-items: center;
}

.modal {
    background-color: white;
    padding: 2rem;
    color: black;
    border-radius: 1rem;
  
    display: flex;
    flex-direction: column;
    gap: 1.4rem;
  }
</style>