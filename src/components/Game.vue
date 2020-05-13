<template>
  <div class="game">
    <span class="round" v-on:click="clickOnRound"></span>
  </div>
</template>

<script>
export default {
  name: 'game',
  methods: {
    clickOnRound: function (ev) {
    }
  }
}
</script>

<style scoped>
  .game {
    width: 100%;
    height: 50%;
    display: block;
    background: darkslategray
  }
  .round {
    height: 50px;
    width: 50px;
    background: aliceblue;
    border-radius: 9999px;
    position: absolute;
    margin: 20% 20%
  }
</style>
