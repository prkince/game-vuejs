<template>
  <div class='content'>
    <div class='log'>
      <button type="submit" class="btn-secondary" @click="startAgain" v-if='player'>RESTART THE GAME</button>
      <p v-for='item in collection' :key="item.id"> {{ item.message }} </p>
    </div>
    <img v-if="!player || stopped" class="backgroundImg"  src="https://source.unsplash.com/random/?wallpapers&1">
    <div v-else class="game" @click="clickOnInterface">
      <span class='time' v-if='time === 0 || !stopped' id="timerDisplay">{{ time }}</span>
      <span class='score' v-if='!stopped'> {{ click }}</span>
      <span v-if='player && !stopped' class="round" :style='roundStyle'
            :class='{ bonus: bonusActivated, badColor: badColorActivated }'
            @click.exact.stop="clickOnForm($event, true)"
            @click.alt.stop='bonus'></span>
      <span v-if='player && !stopped' class="cube" :style='cubeStyle'
            :class='{ bonus: bonusActivated, badColor: badColorActivated }'
            @click.exact.stop="clickOnForm($event, false)"
            @click.alt.stop='bonus'></span>
    </div>
    <div id="scoreBox" class="popup-prk-score">
      <div class="popup-prk-score-content">
        <div class="popup-prk-score-head">
          <span class="close-score" @click="startAgain">x</span>
          <h2> {{ this.finalScore() }}</h2>
          <button type="submit" class="btn-secondary" @click="startAgain">PLAY AGAIN</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'GameComponent',
  props: ['player'],
  data() {
    return {
      click: 0,
      time: 15,
      timerValue: 15,
      roundStyle: {
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
      stopped: true,
      scores: []
    }
  },
  created() {
    document.onkeydown = this.start;
  },
  watch: {
    player: {
      handler() {
        this.timer();
        this.stopped = false;
      }
    },
    time: {
      handler() {
        if (this.time === 0) {
          this.scoreModalRules();
        }
      }
    }
  },
  methods: {
    timer() {
      this.time = 15;
      clearInterval(this.timerValue);
      this.timerValue = setInterval(() => {
        if (this.time <= 0) {
          clearInterval(this.timerValue);
        }
        document.getElementById("timerDisplay").innerHTML = this.time;
        this.time -= 1;
      }, 1000);
    },
    startAgain() {
      this.addLog("Let's play again!");
      this.scores.push(this.click);
      this.click = 0;
      this.timer();
      this.stopped = false;
      this.$parent.score = 0;
      document.getElementById('scoreBox').style.display = 'none';
      this.updateCube();
      this.updateRound();
    },
    finalScore() { // Adding one final Score Popup
      if (this.click === 0) {
        return `You did not play! You may try again :)`;
      } else if (this.$parent.score <= 0) {
        return `Your score is negative, ${this.$parent.score}, you may try again!`;
      } else {
        return `Your score is ${this.$parent.score}, congrats!`;
      }
    },
    clickOnForm(ev, form) {
      if (form) {
        this.updateRound();
        setTimeout(this.updateCube, 1000);
      } else {
        this.updateCube();
        setTimeout(this.updateRound, 1000);
      }
      this.updateClick(true);
      ev.target.className === 'cube' || ev.target.className === 'cube bonus' ? console.log('CUBE!') : console.log('ROUND!');
      this.addLog(`Bravo!`);
    },
    bonus() {
      if (this.bonusActivated) {
        this.updateClick(true);
        this.addLog(`Perfect! (+2)`);
      } else {
        this.updateClick();
        this.addLog(`Why ?? (-1)`);
      }
    },
    start(ev) {
      if (ev.key === 'Enter') { // Launch game on keydown Enter
        console.log('start')
      }
    },
    clickOnInterface() {
      this.updateClick()
      this.addLog(`Ho no! (-1)`)
    },
    updateRound() { // Reference useful to make global changes on one element
      const obj = this.randomSize();
      this.roundStyle.height = `${obj.size}px`; // select and modify height
      this.roundStyle.width = `${obj.size}px`; // select and modify width
      this.roundStyle.margin = `${obj.top}% 0% 0% ${obj.left}%`; // change margin element on both axis, make it move accordingly
    },
    updateCube() {
      const obj = this.randomSize();
      this.cubeStyle.height = `${obj.size}px`;
      this.cubeStyle.width = `${obj.size}px`;
      this.cubeStyle.margin = `${obj.top}% 0% 0% ${obj.left}%`;
    },
    randomSize() {
      const size = Math.random() * (100 - 10) + 10; // new random size between 100 & 10 px
      const top = Math.random() * (45 - 5) + 5; // Start and max end in % on vertical axis of margin
      const left = Math.random() * (60 - 5) + 5; // Start and max end in % on horizontal axis of margin
      this.badColorActivated = size < 20;
      this.bonusActivated = size > 80;
      return {size, top, left}
    },
    addLog(message) {
      if (!this.player || this.stopped) {
        return;
      }
      this.collection.unshift({id: this.collection.length + 1, message: message})
    },
    updateClick(increment) {
      if (!this.player || this.stopped) {
        return;
      }
      increment ? this.click++ : this.click--;
      this.$emit('score', this.click);
    },
    scoreModalRules() {
      const popupPrk = document.getElementById('scoreBox');
      popupPrk.style.display = 'block';
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
  background: yellowgreen;
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

.time {
  opacity: 0.8;
  position: absolute;
  font-size: 90pt;
  padding-left: 30px;
  color: darkgoldenrod;
  cursor: default
}

.score {
  opacity: 0.8;
  position: absolute;
  font-size: 90pt;
  right: 30px;
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
  background-color: rgb(0, 0, 0);
  background-color: rgba(0, 0, 0, 0.4);
  @media (max-width: 500px) {
    padding-top: 25%;
  }
}

.popup-prk-score-content {
  position: relative;
  background-color: #fefefe;
  margin: auto;
  padding: 10px 10px 10px 10px;
  width: 60%;
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
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
  from {
    top: -300px;
    opacity: 0
  }
  to {
    top: 0;
    opacity: 1
  }
}

@keyframes animatetop {
  from {
    top: -300px;
    opacity: 0
  }
  to {
    top: 0;
    opacity: 1
  }
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

.backgroundImg {
  width: 100%;
  height: auto;
  overflow: hidden;
}
</style>
