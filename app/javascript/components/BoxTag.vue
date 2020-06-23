<template>
  <span>
    <el-tag :type="info.color">
      {{info.label}}
    </el-tag>
  </span>
</template>

<script>
const LABELS = {
  no_box: {
    label: 'No box',
    color: 'info'
  },
  box_md_eu: {
    label: 'EU',
    color: 'success'
  },
  box_md_jp: {
    label: 'JP',
    color: 'danger'
  },
  box_genesis: {
    label: 'Genesis',
    color: 'danger'
  }
};

export default {
  props: {
    game: {
      type: Object,
      required: true
    }
  },
  computed: {
    info() {
      const { box } = this.game;
      const info = LABELS.find(label => label[box]);

      return info;
    }
  }
}
</script>
