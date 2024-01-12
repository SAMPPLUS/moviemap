<template>
    <div class="modal-inner">
      <h2>This is a modal window!</h2>
      <p>You have done such great work! Really! I really mean it! </p>
    </div>
  </template>
  
  <script setup lang="ts"></script>
  
  <style scoped>
  * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
  }

  .modal-inner {
  }

  .modal-inner > h2 {
    font-size: 3rem;
    font-weight: bold;
  }
  
  .modal-inner > p {
    font-size: 1.8rem;
    font-weight: 300;
  }
  </style>