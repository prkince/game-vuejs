<template>
    <div class="score">
         {{ score ? `Your score is ${score}.` : 'Press Enter to begin.' }} <!--  We can write JS directly into double quotes-->
    </div>
</template>
<script>
export default {
  name: 'score',
  props: ['score']
}
</script>

<style scoped>
  .score {
    text-align: center;
  }
</style>
