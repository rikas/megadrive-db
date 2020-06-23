<template>
  <div class="select-options">
    <slot></slot>
  </div>
</template>

<script>
export default {
  props: {
    visible: {
      type: Boolean,
      default: false
    }
  },
  data() {
    return {
      listener: null,
      initialized: false
    };
  },
  mounted() {
    this.$nextTick(() =>
      this.listener = document.addEventListener('mousedown', this.handleClick)
    );
  },
  destroyed() {
    document.removeEventListener('mousedown', this.listener);
  },
  methods: {
    handleClick(event) {
      const { target } = event;

      if (!this.visible) {
        return;
      }

      if (!this.$el.contains(target)) {
        this.$emit('onHide');
      }
    }
  }
};
</script>
