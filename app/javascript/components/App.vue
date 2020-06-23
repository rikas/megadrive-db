<template>
  <div id="app">
    <div class="main-title">
      <h1>
        My Mega Drive collection
      </h1>
    </div>

    <h2 v-if="loading" class="subtitle">
      <Placeholder width="32" color="#595995"></Placeholder>
    </h2>

    <h2 v-else class="subtitle">
      The collection is <strong>{{ percentageComplete }}%</strong>
      complete — ({{ ownedGames.length }} / {{ games.length }})
    </h2>

    <div class="table-summary">
      <h2 v-if="loading" style="width:15%">
        <Placeholder width="100"></Placeholder>
      </h2>

      <h2 v-else>
        Listing {{ pluralize(filteredGames.length, 'game') }}
      </h2>

      <div class="filter-controls">
        <Search :games="games" :disabled="loading" @onComplete="onSearch">
        </Search>

        <Dropdown v-model="ownedFilter" :options="ownedOptions" :disabled="loading">
        </Dropdown>
      </div>
    </div>

    <games-table :games="filteredGames" :loading="loading">
    </games-table>

    <footer>
      &copy; {{ new Date().getFullYear() }}
      <a href="https://oterosantos.com">Ricardo Otero</a>
    </footer>
  </div>
</template>

<script>
import axios from 'axios';
import GamesTable from './GamesTable';
import Search from './Search';
import Dropdown from './Dropdown';
import Placeholder from './Placeholder';
import { OwnedOptions } from '../variables';

export default {
  components: {
    GamesTable,
    Search,
    Dropdown,
    Placeholder
  },
  data() {
    return {
      nameSearch: '',
      ownedOptions: OwnedOptions,
      ownedFilter: 'both',
      games: [],
      loading: true
    };
  },
  computed: {
    ownedGames() {
      return this.games.filter(game => game.owned);
    },
    missingGames() {
      return this.games.filter(game => !game.owned);
    },
    percentageComplete() {
      if (this.games.length === 0) {
        return 0.0.toFixed(2);
      }

      return ((this.ownedGames.length * 100) / this.games.length).toFixed(2);
    },
    filteredGames() {
      let filtered = this.games;

      if (this.ownedFilter === 'both') {
        filtered = this.games;
      } else {
        filtered = (this.ownedFilter === 'owned') ? this.ownedGames : this.missingGames;
      }

      if (this.nameSearch !== '') {
        filtered = filtered.filter(game => game.name.match(new RegExp(this.nameSearch, 'i')));
      }

      return filtered;
    }
  },
  mounted() {
    axios.get('/games.json')
      .then(response => {
        this.games = response.data;
      })
      .catch(error => {
        console.log(error);
      })
      .then(() => {
        this.loading = false;
      });
  },
  methods: {
    pluralize(count, text) {
      let finalText = text;

      if (count > 1 || count === 0) {
        finalText = `${finalText}s`;
      }

      return `${count} ${finalText}`;
    },
    onSearch(search) {
      this.nameSearch = search;
    }
  }
};
</script>
