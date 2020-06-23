<template>
  <div class="placeholder" :style="style"></div>
</template>

<script>
export default {
  props: {
    width: {
      type: String,
      default: '0'
    },
    color: {
      type: String,
      default: '#333355'
    }
  },
  computed: {
    style() {
      const max = 80;
      const min = 20;
      const randomWidth = Math.floor(Math.random() * (max - min + 1) + min);

      const width = (this.width > 0) ? this.width : randomWidth;

      return {
        width: `${width}%`,
        background: `linear-gradient(to right, ${this.color} 2%, #999 18%, ${this.color} 33%)`
      };
    }
  }
};
</script>

<style lang="scss">
div.placeholder {
  display: inline-block;
  height: 1em;
  opacity: .3;

  animation-duration: 3s;
  animation-fill-mode: forwards;
  animation-iteration-count: infinite;
  animation-timing-function: linear;
  animation-name: placeholderAnimate;
  //background: #f6f7f8; // Fallback
  // background: linear-gradient(to right, #eee 2%, #ddd 18%, #eee 33%);
  background-size: 1300px; // Animation Area
}

@keyframes placeholderAnimate {
  0%{ background-position: -650px 0; }
  100%{ background-position: 650px 0; }
}
</style>
