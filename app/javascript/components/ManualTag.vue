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
  no_manual: {
    label: 'No manual',
    color: 'danger'
  },
  manual_md_eu: {
    label: 'EU',
    color: 'success'
  },
  manual_md_jp: {
    label: 'JP',
    color: 'danger'
  },
  manual_genesis: {
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
      const { manual } = this.game;
      const info = LABELS[manual];

      return info;
    }
  }
};
</script>
