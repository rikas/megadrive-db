<template>
  <div id="app">
    <div class="main-title">
      <img src="../images/md_icon.png" height="52" />
      <h1 class="ml-3">
        My Mega Drive collection
      </h1>
    </div>

    <div class="filter-controls mb-4">
      <Search :games="games" @onComplete="searchFilter">
      </Search>

      <Dropdown v-model="ownedFilter" :options="ownedOptions">
      </Dropdown>
    </div>

    <h2>Listing {{ filteredGames.length }} games</h2>

    <games-table :owned-filter="ownedFilter" @onLoad="gamesLoaded">
    </games-table>
  </div>
</template>

<script>
import GamesTable, { OWNED_OPTIONS } from './GamesTable';
import Search from './Search';
import Dropdown from './Dropdown';

export default {
  components: {
    GamesTable,
    Search,
    Dropdown
  },
  data() {
    return {
      nameSearch: '',
      ownedOptions: OWNED_OPTIONS,
      ownedFilter: 'both',
      games: [],
      loading: true
    };
  },
  computed: {
    filteredGames() {
      const ownedGames = this.games.filter(game => game.owned);
      const notOwned = this.games.filter(game => !game.owned);

      if (this.ownedFilter === 'both') {
        return this.games;
      }

      return this.ownedFilter === 'owned' ? ownedGames : notOwned;
    }
  },
  methods: {
    searchFilter(search) {

    },
    gamesLoaded(games) {
      this.games = games;
      this.loading = false;
    }
  }
};
</script>

<style>
.main-title {
  display: flex;
  align-items: center;
}

.filter-controls {
  display: flex;
}
</style>
