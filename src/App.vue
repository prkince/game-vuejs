<template>
  <div id="app">
    <player></player>
    <score :score='score'></score>
    <game v-on:score="updateScore"></game>
  </div>
</template>

<script>
import Game from './components/Game'
import Score from './components/Score'
import Player from './components/Player'

export default {
  name: 'App',
  data: function () {
    return {
      score: 0
    }
  },
  components: {
    Game,
    Score,
    Player
  },
  methods: {
    updateScore: function (score) {
      this.score = score
    }
  }
}
</script>

<style>
  #app {
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    height: 100vh;
    display: block
  }
</style>
