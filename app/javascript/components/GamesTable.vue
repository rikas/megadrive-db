<template>
  <table>
    <thead>
      <tr>
        <th width="50">
          Num.
        </th>
        <th>Name</th>
        <th width="90">
          Box
        </th>
        <th width="90">
          Cartridge
        </th>
        <th width="90">
          Manual
        </th>
        <th width="90">
          PT Manual
        </th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="game in games" :key="game.id" :class="tableRowClassName(game)">
        <td>
          {{ game.id.toString().padStart(3, '0') }}
        </td>
        <td>
          <OwnedIcon :game="game"></OwnedIcon>
          <span class="ml-3">{{ game.name }}</span>
        </td>
        <td>
          <Tag :value="game.box" :owned="game.owned" :labels="BoxLabels">
          </Tag>
        </td>
        <td>
          <Tag :value="game.cartridge" :owned="game.owned" :labels="CartLabels">
          </Tag>
        </td>
        <td>
          <Tag :value="game.manual" :owned="game.owned" :labels="ManualLabels">
          </Tag>
        </td>
        <td>
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
import {
  CartLabels,
  ManualLabels,
  PTManualLabels,
  BoxLabels
} from '../variables';

export default {
  components: {
    OwnedIcon,
    Tag
  },
  props: {
    games: {
      type: Array,
      default: () => []
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
  td.empty-state {
    text-align: center;
    opacity: .6;
    padding: 100px;
  }

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
