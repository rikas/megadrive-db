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

<style lang="scss">
.select-options {
  z-index: 100;
  position: absolute;
  background: #fff;
  width: 100%;
  max-height: 250px;
  overflow: auto;
  box-shadow: 0 3px 6px -4px rgba(0,0,0,.12), 0 6px 16px 0 rgba(0,0,0,.08), 0 9px 28px 8px rgba(0,0,0,.05);
  margin-top: .2rem;
  padding-bottom: 3px;

  ul {
    list-style: none;
    margin: 0;
    padding: 0;

    li {
      margin: 0;
      padding: 0;
    }
  }

  button {
    text-align: left;
    display: block;
    width: 100%;
    cursor: pointer;
    color: currentColor;
    font-size: .9em;
    background: transparent;
    border: 0;
    padding: 8px 20px;

    &:focus, &.focus {
      outline: none;
      background-color: #efefef;
    }

    &:hover {
      background-color: #efefef;
    }
  }
}
</style>
