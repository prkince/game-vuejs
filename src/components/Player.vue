<template>
    <div class= 'playerCenter'>
       <span v-html="welcomeMessage" :class="{ hide: !player }"></span> <!-- if there is no player it will be hidden -->
       <div class="playerDetails">
        <div>
          <span :class="{ hide: player }">Welcome to my Game </span>
          <a id="popup-prkLink" href="#" v-on:click="modalRules">Rules</a>
          <div id="popup-prkBox" class="popup-prk">
            <div class="popup-prk-content">
                <div class="popup-prk-head">
                    <span class="close">x</span>
                    <h2>Rules</h2>
                </div>
                <div class="popup-prk-main">
                  <p> Type your name and start the game</p>
                  <p> Click on the ball or the cube to gain 1 point</p>
                  <p> Click on one of them with ALT once color is blue to double the point!</p>
                </div>
            </div>
          </div>
        </div>
        <form @submit.prevent="setPlayer" :class="{ hide: player }"> <!-- if there is a player it will be hidden -->
            <div class="formInput">
                <input name="player" class='' placeholder="Type your name here">
                <button type="submit" class="btn-secondary">PLAY</button>
            </div>
        </form>
       </div>
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
        return
      }
      this.player = playerName.charAt(0).toUpperCase() + playerName.slice(1) // Assign new playerName & capitalize it
      this.$emit('player') // Export player's name
    },
    modalRules: function () {
      const popupPrk = document.getElementById('popup-prkBox') // get the popup
      const close = document.getElementsByClassName('close')[0] // get the close action element
      popupPrk.style.display = 'block' // open the popup once the link is clicked
      close.onclick = function () { // close the popup once close element is clicked
        popupPrk.style.display = 'none'
      }
      popupPrk.onclick = function (event) { // close the popup when user clicks outside of the box
        if (event.target === popupPrk) {
          popupPrk.style.display = 'none'
        }
      }
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
    .playerCenter {
      text-align: center
    }
    .playerDetails {
     display: flex;
     justify-content: space-around;
     padding: 10px;
    }
    .formInput {
      width: 500px;
    }
    input {
      width: 50%
    }

    /* popup-prk box style */
    .popup-prk {
        display: none;
        position: fixed;
        z-index: 1;
        padding-top: 15%;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgb(0,0,0);
        background-color: rgba(0,0,0,0.4);
        @media (max-width: 500px) {
            padding-top: 25%;
        }
    }

    #popup-prkLink {
        color: #808080;
        margin: 0 0 0 0;
        text-decoration: none;
        font-size: 15px;
    }

    .popup-prk-content {
        position: relative;
        background-color: #fefefe;
        margin: auto;
        padding: 10px 10px 10px 10px;
        width: 60%;
        box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
        -webkit-animation-name: animatetop;
        -webkit-animation-duration: 0.4s;
        animation-name: animatetop;
        animation-duration: 0.4s;
        opacity: 0.9;
        @media (max-width: 500px) {
            width: 90%;
        }
    }
    .popup-prk-head {
        padding: 2px 16px;
        background: white;
        opacity: 0.8;
        text-align: center;
    }
    .popup-prk-main {
        padding: 2px 16px;
        text-align: center;
    }

    /* add animation effects */
    @-webkit-keyframes animatetop {
        from {top:-300px; opacity:0}
        to {top:0; opacity:1}
    }

    @keyframes animatetop {
        from {top:-300px; opacity:0}
        to {top:0; opacity:1}
    }

    /* close button style */
    .close {
        color: lightgrey;
        float: right;
        font-size: 28px;
        font-weight: bold;
    }
    .close:hover, .close:focus {
        color: #000;
        text-decoration: none;
        cursor: pointer;
    }
</style>
