<template>
    <div class="score">
         {{ score ? `Your score is ${score}.` : 'Press Enter to begin.' }} <!--  We can write JS directly into double quotes-->
    </div>
</template>
<script>
export default {
  name: 'score',
  data: function () {
    return {
      score: 0
    }
  }
}
</script>

<style scoped>

</style>
