<template>
  <table :style="tableStyle">
    <thead>
      <tr>
        <th class="hide-sm" width="50">
          Num.
        </th>
        <th>Name</th>
        <th class="hide-sm">
          Box
        </th>
        <th class="hide-sm">
          Cartridge
        </th>
        <th class="hide-sm">
          Manual
        </th>
        <th class="hide-sm">
          PT Manual
        </th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="game in loadedGames" :key="game.id" :class="tableRowClassName(game)">
        <td class="hide-sm">
          {{ game.id.toString().padStart(3, '0') }}
        </td>
        <td>
          <OwnedIcon :game="game"></OwnedIcon>
          <span v-if="loading" class="ml-2">
            <Placeholder></Placeholder>
          </span>
          <span v-else class="ml-2">{{ game.name }}</span>
        </td>
        <td class="hide-sm">
          <Tag :value="game.box" :owned="game.owned" :labels="BoxLabels">
          </Tag>
        </td>
        <td class="hide-sm">
          <Tag :value="game.cartridge" :owned="game.owned" :labels="CartLabels">
          </Tag>
        </td>
        <td class="hide-sm">
          <Tag :value="game.manual" :owned="game.owned" :labels="ManualLabels">
          </Tag>
        </td>
        <td class="hide-sm">
          <Tag :value="game.pt_manual.toString()" :owned="game.owned" :labels="PTManualLabels">
          </Tag>
        </td>
      </tr>
      <tr v-if="games.length === 0">
        <td colspan="6" class="empty-state">
          No games found!
        </td>
      </tr>
    </tbody>
  </table>
</template>

<script>
import OwnedIcon from './OwnedIcon';
import Tag from './Tag';
import Placeholder from './Placeholder';
import {
  CartLabels,
  ManualLabels,
  PTManualLabels,
  BoxLabels
} from '../variables';

const placeholderGames = () => {
  const placeholderGames = [];

  for (let i=0; i< 100; i++) {
    placeholderGames.push({
      id: i + 1,
      name: '—',
      box: '—',
      cartridge: '—',
      manual: '—',
      pt_manual: '—',
      owned: false,
      status: 'none'
    });
  }

  return placeholderGames;
};

export default {
  components: {
    OwnedIcon,
    Tag,
    Placeholder
  },
  props: {
    games: {
      type: Array,
      default: () => []
    },
    loading: {
      type: Boolean,
      default: false
    }
  },
  data() {
    return {
      CartLabels,
      ManualLabels,
      PTManualLabels,
      BoxLabels
    };
  },
  computed: {
    loadedGames() {
      if (this.loading) {
        return placeholderGames();
      } else {
        return this.games;
      }
    },
    tableStyle() {
      if (this.loading) {
        return {
          opacity: .4
        };
      }

      return {};
    }
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

<style lang="scss">
  td .empty-tag {
    opacity: .4;
  }

  td .danger {
    color: #992222;
  }

  td .success {
    color: #229922;
  }

  .missing-row {
    opacity: .50;
  }

  .warning-row {
    background: #fdf5e6;

    .fas.success {
      color: darken(#fdf5e6, 30);
    }
  }

  .success-row {
    background: #f0f9eb;
  }
</style>
