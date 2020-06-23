<template>
  <span>
    <i v-if="isOwned" class="fas fa-check"></i>
    <i v-else class="far fa-circle"></i>
  </span>
</template>

<script>
export default {
  props: {
    game: {
      type: Object,
      default: () => {}
    }
  },
  computed: {
    isOwned() {
      return this.game.owned;
    }
  }
};
</script>
