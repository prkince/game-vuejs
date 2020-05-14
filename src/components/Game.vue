<template>
  <div class='content'>
    <div class='log'>
      <p v-for='item in collection' :key="item.id"> Turn: {{ item.id }} - {{ item.message }} </p>
    </div>
    <div class="game" @click="clickOnInterface">
      <span class="round" :style='roundStyle' :class='{ bonus: bonusActivated, badColor: badColorActivated }' @click.exact.stop="clickOnRound" @click.alt.stop='bonus'></span> <!--Stop the event to occur-->
      <span class="cube" :style='cubeStyle' :class='{ bonus: bonusActivated, badColor: badColorActivated }' @click.exact.stop="clickOnRound" @click.alt.stop='bonus'></span> <!--Stop the event to occur-->
    </div>
  </div>
</template>

<script>
export default {
  name: 'game',
  data: function () {
    return {
      click: 0, // Reference number of click and launch method as soon as there is an update
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
      collection: []
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
    }
  },
  methods: {
    clickOnRound: function (ev) {
      this.click++
      ev.target.className === 'cube' || ev.target.className === 'cube bonus' ? console.log('CUBE!') : console.log('ROUND!')
      this.addLog(`Bravo!`)
    },
    bonus: function (ev) {
      // alert('Bravo tu as droit à un bonus')
      if (this.bonusActivated) {
        this.click += 2
        this.addLog(`Perfect! (+2)`)
      } else {
        this.click--
        this.addLog(`Why ?? (-1)`)
      }
    },
    start: function (ev) {
      if (ev.key === 'Enter') { // Launch game on keydown Enter
        console.log('start')
      }
    },
    clickOnInterface: function () {
      this.click--
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
      this.collection.unshift({id: this.collection.length + 1, message: message})
    }

  }
}
</script>

<style scoped>

  .game {
    width: 100%;
    height: 100%;
    display: block;
    background: black
  }
  .round {
    background: aliceblue;
    border-radius: 9999px;
    position: absolute;
  }

  .cube {
    background: salmon;
    position: absolute;
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
</style>
