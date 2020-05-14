<template>
    <div>
       <span v-html="welcomeMessage" :class="{ hide: !player }"></span> <!-- if there is no player it will be hidden -->
       <form @submit.prevent="setPlayer" :class="{ hide: player }"> <!-- if there is a player it will be hidden -->
           <input name="player" class='btn-prk form-contro' placeholder="Type your name here">
           <button type="submit" class="btn btn-secondary">Play</button>
       </form>
    </div>
</template>

<script>
export default {
  name: 'player',
  data: function () {
    return {
      player: '',
      welcomeMessage: ''
    }
  },
  updated: function () {
    this.welcomeMessage = `Hello <span class="player">${this.player} </span> !`
  },
  methods: {
    setPlayer: function (ev) {
      let playerName = ev.target[0].value // Select the player Name
      if (!playerName) { // Display a message if nothing is written into the input
        alert('Please add a Player Name!')
      }
      this.player = playerName // Assign new playerName
    }
  }
}
</script>

<style scoped>
    .btn-prk{
        width: 20%;
    }
    .hide {
      display: none
    }
</style>
