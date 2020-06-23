<template>
  <div class="search">
    <input
      ref="input"
      v-model="input"
      type="text"
      class="search-field"
      placeholder="Search games"
      :disabled="disabled"
      @input="resetOption"
      @keydown.prevent.enter="onEnter"
      @keydown.prevent.up="focusOptionsUp"
      @keydown.prevent.down="focusOptionsDown" />
    <SelectOptions v-show="shouldShowOptions" :visible="shouldShowOptions" @onHide="optionsHide">
      <ul>
        <li v-for="(game, index) in suggestedGames" :key="game.id">
          <button :class="{ focus: index === focusedOption }" @click="clickOption">
            <span class="mr-1"><OwnedIcon :game="game"></OwnedIcon></span> {{ game.name }}
          </button>
        </li>
      </ul>
    </SelectOptions>
  </div>
</template>

<script>
import OwnedIcon from './OwnedIcon';
import SelectOptions from './SelectOptions';

export default {
  components: {
    OwnedIcon,
    SelectOptions
  },
  props: {
    games: {
      type: Array,
      default: () => []
    },
    maxResults: {
      type: Number,
      default: 7
    },
    disabled: {
      type: Boolean,
      default: false
    }
  },
  data() {
    return {
      input: '',
      focusedOption: -1,
      showOptions: false
    };
  },
  computed: {
    shouldShowOptions() {
      return this.suggestedGames.length > 0 && this.showOptions;
    },
    suggestedGames() {
      if (!this.input || this.input === '') {
        return [];
      }

      const matching = this.games.filter(game => game.name.match(new RegExp(this.input, 'i')));

      return matching.slice(0, this.maxResults);
    }
  },
  methods: {
    optionsHide() {
      this.showOptions = false;
    },
    clickOption(event) {
      const { target } = event;
      const { innerText } = target;

      this.input = innerText.trim();
      this.emitSelection();
    },
    resetOption() {
      if (this.input.length > 1) {
        this.showOptions = true;
      }

      this.focusedOption = -1;
    },
    focusOptionsDown() {
      const newIndex = this.focusedOption + 1;

      this.focusedOption = Math.min(this.maxResults - 1, newIndex);
    },
    focusOptionsUp() {
      const newIndex = this.focusedOption - 1;

      this.focusedOption = Math.max(newIndex, 0);
    },
    onEnter() {
      if (this.focusedOption > -1) {
        this.input = this.suggestedGames[this.focusedOption].name;
      }

      this.emitSelection();
    },
    emitSelection() {
      this.showOptions = false;
      this.$emit('onComplete', this.input);
      this.$refs.input.blur();
    }
  }
};
</script>

<style lang="scss">
.search {
  position: relative;
  margin-right: 20px;
}

.search-field {
  width: 100%;
  padding-left: 40px; // to compensate for the icon
  width: 330px;
}
</style>
