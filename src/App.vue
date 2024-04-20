<template>
  <div id="app">
    <player :player='player' @player='updatePlayer'></player>
    <game :player='player' @score="updateScore"></game>
  </div>
</template>

<script>
import Game from './components/Game'
import Player from './components/Player'

export default {
  name: 'App',
  data() {
    return {
      score: 0, player: false
    }
  },
  components: {
    Game,
    Player
  },
  methods: {
    updateScore(score) {
      this.score = score;
    },
    updatePlayer() {
      this.player = true;
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
