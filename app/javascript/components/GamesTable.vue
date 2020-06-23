<template>
  <table>
    <thead>
      <tr>
        <th width="50">Num.</th>
        <th>Name</th>
        <th>Box</th>
        <th>Cartridge</th>
        <th>Manual</th>
        <th>PT Manual</th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="game in filteredGames" :key="game.id" :class="tableRowClassName(game)">
        <td>
          {{ game.id.toString().padStart(3, '0') }}
        </td>
        <td>
          <OwnedIcon :game="game"></OwnedIcon>
          <span class="ml-3">{{ game.name }}</span>
        </td>
        <td>{{game.box}}</td>
        <td>{{game.cartridge}}</td>
        <td>{{game.manual}}</td>
        <td>{{game.pt_manual}}</td>
      </tr>
    </tbody>
  </table>
</template>

<script>
import axios from 'axios';
import BoxTag from './BoxTag';
import OwnedIcon from './OwnedIcon';

export const OWNED_OPTIONS = [
  {
    key: 'both',
    label: 'All games'
  },
  {
    key: 'owned',
    label: 'Owned'
  },
  {
    key: 'not_owned',
    label: 'Not owned'
  }
];

export default {
  components: {
    BoxTag,
    OwnedIcon
  },
  props: {
    ownedFilter: {
      type: String,
      default: 'both'
    }
  },
  data() {
    return {
      games: []
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
  mounted() {
    axios.get('/games.json')
      .then(response => {
        this.games = response.data;
        this.$emit('onLoad', response.data);
      })
      .catch(error => {
        console.log(error);
      })
      .then(() => {
        // Always run
      });
  },
  methods: {
    tableRowClassName({ status }) {
      if (status === 'full') {
        return 'success-row';
      } else if(status === 'partial') {
        return 'warning-row';
      }

      return 'missing-row';
    },
  }
};
</script>

<style>
  .missing-row {
    opacity: .75;
  }

  .warning-row {
    background: oldlace;
  }

  .success-row {
    background: #f0f9eb;
  }
</style>
