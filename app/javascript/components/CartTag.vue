<template>
  <span>
    <span v-if="game.owned" :class="info.color">{{ info.label }}</span>
    <span v-else class="empty-tag">
      &mdash;
    </span>
  </span>
</template>

<script>
const LABELS = {
  no_cart: {
    label: 'No cart',
    color: 'danger'
  },
  cart_md_eu: {
    label: 'EU',
    color: 'success'
  },
  cart_md_jp: {
    label: 'JP',
    color: 'danger'
  },
  cart_genesis: {
    label: 'Genesis',
    color: 'danger'
  }
};

export default {
  props: {
    game: {
      type: Object,
      required: true
    }
  },
  computed: {
    info() {
      const { cartridge } = this.game;
      const info = LABELS[cartridge];

      return info;
    }
  }
};
</script>
