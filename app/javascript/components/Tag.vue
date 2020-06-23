<template>
  <span>
    <span v-if="owned" :class="info.color">{{ info.label }}</span>
    <span v-else class="empty-tag">
      &mdash;
    </span>
  </span>
</template>

<script>
export default {
  props: {
    labels: {
      type: Object,
      required: true
    },
    owned: {
      type: Boolean,
      required: true
    },
    value: {
      type: String,
      required: true
    }
  },
  computed: {
    info() {
      const info = this.labels[this.value];

      return info;
    }
  }
};
</script>
