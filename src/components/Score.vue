<template>
    <div class="score">
        Your score: {{ score }}
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
