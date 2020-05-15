<template>
  <div class='content'>
    <div class='log'>
      <p v-for='item in collection' :key="item.id"> Turn: {{ item.id }} - {{ item.message }} </p>
    </div>
    <div class="game" @click="clickOnInterface" :class='{ wait: !player || stopped }'>
      <span class='time' v-if='!stopped'> {{ time }}</span>
      <span v-if='player && !stopped' class="round" :style='roundStyle' :class='{ bonus: bonusActivated, badColor: badColorActivated }' @click.exact.stop="clickOnRound" @click.alt.stop='bonus'></span> <!--Stop the event to occur-->
      <span v-if='player && !stopped' class="cube" :style='cubeStyle' :class='{ bonus: bonusActivated, badColor: badColorActivated }' @click.exact.stop="clickOnRound" @click.alt.stop='bonus'></span> <!--Stop the event to occur-->
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
      this.time = 10
      let self = this // using self to be able to have this inside setInterval function
      setInterval(function () {
        self.updateTime()
      }, 1000)
    }
  },
  methods: {
    updateTime: function () {
      if (this.time === 0) { // if time = 0, game stop
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
    transition: width 2s, height 2s, margin 0.5s
  }

  .cube {
    background: salmon;
    position: absolute;
    transition: width 2s, height 2s, margin 0.5s
  }

  .bonus {
    background: blue
  }

  .badColor {
    background: lightgrey
  }

  .log {
    width: 100%;
    height: 30px;
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
  }
</style>
