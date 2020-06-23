<template>
  <div class="dropdown-wrapper">
    <div class="dropdown" @click="toggleOptions">
      <div class="selected-option">
        <span>{{ selectedOption.label }}</span>
        <i class="fas fa-chevron-down"></i>
      </div>
    </div>

    <SelectOptions v-show="optionsVisible" :visible="optionsVisible" @onHide="toggleOptions">
      <ul>
        <li v-for="option in options" :key="option.key">
          <button @click="selectOption(option)">
            {{ option.label }}
          </button>
        </li>
      </ul>
    </SelectOptions>
  </div>
</template>

<script>
import SelectOptions from './SelectOptions';

export default {
  components: {
    SelectOptions
  },
  props: {
    options: {
      type: Array,
      default: () => []
    }
  },
  data() {
    return {
      selectedOption: this.options[0],
      optionsVisible: false
    };
  },
  methods: {
    selectOption(option) {
      this.selectedOption = option;
      this.optionsVisible = false;
      this.$emit('input', this.selectedOption.key);
    },
    toggleOptions() {
      this.optionsVisible = !this.optionsVisible;
    }
  }
};
</script>

<style lang="scss">
.dropdown-wrapper {
  cursor: pointer;
  position: relative;
  user-select: none;
  width: 150px;

  .selected-option {
    display: flex;
    align-items: baseline;
    justify-content: space-between;
  }
}
</style>
