<template>
  <div id="app">
    <player :player='player' v-on:player='updatePlayer'></player>
    <score :score='score'></score>
    <game :player='player' v-on:score="updateScore"></game>
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
      score: 0, player: false
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
    },
    updatePlayer: function () {
      this.player = true
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
  h2, p, span {
    cursor: default
  }
</style>
