<template>
  <div class='content'>
    <div class='log'>
      <button type="submit" class="btn-secondary" v-on:click="startAgain" v-if='player'>RESTART</button>
      <p v-for='item in collection' :key="item.id"> {{ item.message }} </p>
    </div>
    <div class="game" @click="clickOnInterface" :class='{ wait: !player || stopped }'>
      <span class='time' v-if='!stopped'> {{ time }}</span>
      <span v-if='player && !stopped' class="round" :style='roundStyle' :class='{ bonus: bonusActivated, badColor: badColorActivated }' @click.exact.stop="clickOnRound" @click.alt.stop='bonus'></span> <!--Stop the event to occur-->
      <span v-if='player && !stopped' class="cube" :style='cubeStyle' :class='{ bonus: bonusActivated, badColor: badColorActivated }' @click.exact.stop="clickOnRound" @click.alt.stop='bonus'></span> <!--Stop the event to occur-->
    </div>
    <div id="popup-prk-scoreBox" class="popup-prk-score">
      <div class="popup-prk-score-content">
        <div class="popup-prk-score-head">
            <span class="close-score">x</span>
            <h2> {{ this.finalScore() }}</h2>
            <button type="submit" class="btn-secondary" v-on:click="startAgain">PLAY AGAIN</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'game',
  props: ['player'],
  data: function () {
    return {
      click: 0, // Reference number of click and launch method as soon as there is an update
      time: 0, // For timer
      roundStyle: { // Define style object ++ add to HTML :style='roundStyle'
        height: '50px',
        width: '50px',
        margin: '20% 20%'
      },
      cubeStyle: {
        height: '50px',
        width: '50px',
        margin: '40% 40%'
      },
      bonusActivated: false,
      badColorActivated: false,
      collection: [],
      stopped: true // stop the timer
    }
  },
  created: function () { // Track keyboard keydown directly from the beginning
    document.onkeydown = this.start
  },
  watch: {
    click: function () {
      this.updateRound()
      this.updateCube()
      this.$emit('score', this.click)
    },
    player: function () { // launch the app and timer as soon as player is online
      this.stopped = false
      this.time = 100
      let self = this // using self to be able to have this inside setInterval function
      setInterval(function () {
        self.updateTime()
      }, 1000)
    },
    time: function () {
      if (this.time === 0) {
        this.scoreModalRules()
      }
    }
  },
  methods: {
    startAgain: function () {
      this.time = 100
      this.$parent.score = 0
      this.stopped = false
      document.getElementById('popup-prk-scoreBox').style.display = 'none'
    },
    finalScore: function () { // Adding one final Score Popup
      if (this.click === 0) {
        return `You did not play! You may try again :)`
      } else if (this.$parent.score <= 0) {
        return `Your score is negative, ${this.$parent.score}, you may try again!`
      } else {
        return `Your score is ${this.$parent.score}, congrats!`
      }
    },
    updateTime: function () {
      if (this.time <= 0) { // if time = 0, game stop
        this.stopped = true
      }
      if (!this.stopped) { // if time is not stopped, reducing time
        this.time--
      }
    },
    clickOnRound: function (ev) {
      setTimeout(this.updateRound, 1000) // Timeout to move the circle after one second if no click
      setTimeout(this.updateCube, 1000)
      this.updateClick(true)
      ev.target.className === 'cube' || ev.target.className === 'cube bonus' ? console.log('CUBE!') : console.log('ROUND!')
      this.addLog(`Bravo!`)
    },
    bonus: function (ev) {
      // alert('Bravo tu as droit à un bonus')
      if (this.bonusActivated) {
        this.updateClick(true)
        this.addLog(`Perfect! (+2)`)
      } else {
        this.updateClick()
        this.addLog(`Why ?? (-1)`)
      }
    },
    start: function (ev) {
      if (ev.key === 'Enter') { // Launch game on keydown Enter
        console.log('start')
      }
    },
    clickOnInterface: function () {
      this.updateClick()
      this.addLog(`Ho no! (-1)`)
    },
    updateRound: function () { // Reference useful to make global changes on one element
      // let element = this.$refs.round // Select the targeted element & move it somewhere else, HTML: ref='round'
      let ar = this.randomSize()
      this.roundStyle.height = `${ar[0]}px` // select and modify height
      this.roundStyle.width = `${ar[0]}px` // select and modify width
      this.roundStyle.margin = `${ar[1]}% 0% 0% ${ar[2]}%` // change margin element on both axis, make it move accordingly
    },
    updateCube: function () { // Creation of new formula for a cube
      let ar = this.randomSize()
      this.cubeStyle.height = `${ar[0]}px`
      this.cubeStyle.width = `${ar[0]}px`
      this.cubeStyle.margin = `${ar[1]}% 0% 0% ${ar[2]}%`
    },
    randomSize: function () {
      let size = Math.random() * (100 - 10) + 10 // new random size between 100 & 10 px
      let top = Math.random() * (45 - 5) + 5 // Start and max end in % on vertical axis of margin
      let left = Math.random() * (60 - 5) + 5 // Start and max end in % on horizontal axis of margin
      this.badColorActivated = size < 20
      this.bonusActivated = size > 80
      return [size, top, left]
    },
    addLog: function (message) {
      if (!this.player || this.stopped) {
        return
      }
      this.collection.unshift({id: this.collection.length + 1, message: message})
    },
    updateClick: function (increment) {
      if (!this.player || this.stopped) {
        return
      }
      if (increment) {
        this.click++
      } else {
        this.click--
      }
    },
    scoreModalRules: function () {
      const popupPrk = document.getElementById('popup-prk-scoreBox') // get the popup
      const close = document.getElementsByClassName('close-score')[0] // get the close action element
      popupPrk.style.display = 'block' // open the popup once the link is clicked
      close.onclick = function () { // close the popup once close element is clicked
        popupPrk.style.display = 'none'
      }
    }

  }
}
</script>

<style scoped>

  .game {
    width: 100%;
    height: 100%;
    display: block;
    background: black;
    opacity: 1;
    transition: opacity 1s;
  }
  .round {
    background: aliceblue;
    border-radius: 9999px;
    position: absolute;
    transition: width 2s, height 2s, margin 0.5s;
    cursor: pointer
  }

  .cube {
    background: salmon;
    position: absolute;
    transition: width 2s, height 2s, margin 0.5s;
    cursor: pointer
  }

  .bonus {
    background: blue
  }

  .badColor {
    background: lightgrey
  }

  .log {
    width: 100%;
    height: 58px;
    padding: 5px;
    background: #dedede;
    display: block;
    overflow: hidden;
    text-align: center
  }
  .content {
    width: 100%;
    height: 100%;
  }
  .wait {
    opacity: 0.3;
  }
  .time {
    opacity: 0.2;
    position: absolute;
    font-size: 90pt;
    padding-left: 30px;
    color: darkgoldenrod;
    cursor: default
  }

   /* popup-prk-score box style */
  .popup-prk-score {
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

  #popup-prk-scoreLink {
      color: #808080;
      margin: 0 0 0 0;
      text-decoration: none;
      font-size: 15px;
  }

  .popup-prk-score-content {
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
  .popup-prk-score-head {
      padding: 2px 16px;
      background: white;
      opacity: 0.8;
      text-align: center;
      cursor: pointer;
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
  .close-score {
      color: lightgrey;
      float: right;
      font-size: 28px;
      font-weight: bold;
  }
  .close-score:hover, .close-score:focus {
      color: #000;
      text-decoration: none;
  }
</style>
