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
        <td>{{ game.box }}</td>
        <td>{{ game.cartridge }}</td>
        <td>{{ game.manual }}</td>
        <td>{{ game.pt_manual }}</td>
      </tr>
    </tbody>
  </table>
</template>

<script>
import OwnedIcon from './OwnedIcon';

export default {
  components: {
    OwnedIcon
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
