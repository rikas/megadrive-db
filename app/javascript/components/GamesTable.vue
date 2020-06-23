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
      <tr v-for="game in games" :key="game.id" :class="tableRowClassName(game)">
        <td>
          {{ game.id.toString().padStart(3, '0') }}
        </td>
        <td>
          <OwnedIcon :game="game"></OwnedIcon>
          <span class="ml-3">{{ game.name }}</span>
        </td>
        <td>
          <BoxTag :game="game">
          </BoxTag>
        </td>
        <td>
          <CartTag :game="game">
          </CartTag>
        </td>
        <td>
          <ManualTag :game="game">
          </ManualTag>
        </td>
        <td>{{ game.pt_manual ? 'Yes' : 'No' }}</td>
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
import BoxTag from './BoxTag';
import ManualTag from './ManualTag';
import CartTag from './CartTag';

export default {
  components: {
    OwnedIcon,
    BoxTag,
    ManualTag,
    CartTag
  },
  props: {
    games: {
      type: Array,
      default: () => []
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

<style>
  td.empty-state {
    text-align: center;
    opacity: .6;
    padding: 40px;
  }

  td .empty-tag {
    opacity: .4;
  }

  td .danger {
    color: red;
  }

  .missing-row {
    opacity: .50;
  }

  .warning-row {
    background: oldlace;
  }

  .success-row {
    background: #f0f9eb;
  }
</style>
