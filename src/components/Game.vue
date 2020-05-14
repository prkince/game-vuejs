<template>
  <div class="game" @click="clickOnInterface">
    <span class="round" :style='roundStyle' @click.exact.stop="clickOnRound" @click.alt.stop='bonus'></span> <!--Stop the event to occur-->
    <span class="cube" :style='cubeStyle' @click.exact.stop="clickOnRound" @click.alt.stop='bonus'></span> <!--Stop the event to occur-->
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
      }
    }
  },
  created: function () { // Track keyboard keydown directly from the beginning
    document.onkeydown = this.start
  },
  watch: {
    click: function () {
      this.updateRound()
      this.updateCube()
    }
  },
  methods: {
    clickOnRound: function (ev) {
      this.click++
      ev.target.className === 'cube' ? console.log('CUBE!') : console.log('ROUND!')
    },
    bonus: function (ev) {
      console.log('bonus')
    },
    start: function (ev) {
      if (ev.key === 'Enter') { // Launch game on keydown Enter
        console.log('start')
      }
    },
    clickOnInterface: function (ev) {
      this.click++
    },
    updateRound: function () { // Reference useful to make global changes on one element
      // let element = this.$refs.round // Select the targeted element & move it somewhere else, HTML: ref='round'
      let ar = this.randomSize()
      this.roundStyle.height = `${ar[0]}px` // select and modify height
      this.roundStyle.width = `${ar[0]}px` // select and modify width
      this.roundStyle.margin = `${ar[1]}% ${ar[2]}%` // change margin element on both axis, make it move accordingly
    },
    updateCube: function () { // Creation of new formula for a cube
      let ar = this.randomSize()
      this.cubeStyle.height = `${ar[0]}px`
      this.cubeStyle.width = `${ar[0]}px`
      this.cubeStyle.margin = `${ar[1]}% ${ar[2]}%`
    },
    randomSize: function () {
      let size = Math.random() * (100 - 10) + 10 // new random size between 100 & 10 px
      let top = Math.random() * (35 - 5) + 5 // Start and max end in % on vertical axis of margin
      let left = Math.random() * (35 - 5) + 5 // Start and max end in % on horizontal axis of margin
      return [size, top, left]
    }

  }
}
</script>

<style scoped>
  .game {
    width: 100%;
    height: 80vh;
    display: block;
    background: darkslategray
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
</style>
