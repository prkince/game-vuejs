<template>
    <div>
       <span v-html="welcomeMessage"></span>
       <form v-hide v-on:submit.prevent="setPlayer">
           <input name="player" class='btn-prk' placeholder="Type your name here" v-border:salmon>
           <button type="submit" v-border:grey>Play</button>
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
  directives: {
    border: function (el, binding) {
      el.style.borderColor = binding.arg
    },
    hide: function (el, binding, vnode) {
      let isForm = vnode.tag === 'form'
      let player = vnode.context.player
      if (isForm) {
        el.style.display = player ? 'none' : 'block'
      } else {
        el.style.display = player ? 'block' : 'none'
      }
    }
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
</style>
