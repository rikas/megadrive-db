<template>
  <div ref="input" class="search">
    <input
      v-model="input"
      type="search"
      class="search-field"
      placeholder="Search"
      @focus="showSuggestion = true"
      @blur="showSuggestion = false"
      @input="resetSuggestion"
      @keydown.prevent.enter="onEnter"
      @keydown.prevent.up="focusSuggestionsUp"
      @keydown.prevent.down="focusSuggestionsDown" />
    <SelectOptions v-if="suggestedGames && showSuggestion">
      <ul>
        <li v-for="(game, index) in suggestedGames" :key="game.id">
          <button :class="{ focus: index === focusedSuggestion }" @click="clickSuggestion">
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
    }
  },
  data() {
    return {
      input: 'sonic',
      showSuggestion: false,
      focusedSuggestion: 0
    };
  },
  computed: {
    suggestedGames() {
      if (!this.input || this.input === '') {
        return [];
      }

      const matching = this.games.filter(game => game.name.match(new RegExp(this.input, 'i')));

      return matching.slice(0, this.maxResults);
    }
  },
  methods: {
    clickSuggestion(event) {
      const { target } = event;
      const { innerText } = target;

      this.input = innerText.trim();
      this.emitSelection();
    },
    resetSuggestion() {
      this.focusedSuggestion = 0;
    },
    focusSuggestionsDown() {
      const newIndex = this.focusedSuggestion + 1;

      this.focusedSuggestion = Math.min(this.maxResults - 1, newIndex);
    },
    focusSuggestionsUp() {
      const newIndex = this.focusedSuggestion - 1;

      this.focusedSuggestion = Math.max(newIndex, 0);
    },
    onEnter() {
      if (this.focusedSuggestion) {
        this.input = this.suggestedGames[this.focusedSuggestion].name;
      }

      this.emitSelection();
    },
    emitSelection() {
      this.$emit('onComplete', this.input);
      this.$refs.input.blur();
    }
  }
};
</script>

<style lang="scss">
.search {
  position: relative;
  width: 400px;
}

.search-field {
  position: relative;
  width: 100%;
}
</style>
