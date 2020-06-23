ActiveAdmin.register Game do
  actions :index, :show, :edit, :update

  permit_params :name, :owned, :notes, :box, :cartridge, :manual, :pt_manual

  scope :all
  scope :owned
  scope :not_owned, default: true

  config.sort_order = 'id_asc'

  member_action :set_owned, method: :patch do
    resource.update(owned: true, box: :box_md_eu, cartridge: :cart_md_eu, manual: :manual_md_eu)

    redirect_to edit_admin_game_path(resource), notice: 'Game is now owned with default settings'
  end

  member_action :set_partial, method: :patch do
    resource.update(owned: true, box: :box_md_eu, cartridge: :cart_md_eu)

    redirect_to collection_path, notice: 'Game is now owned without manual'
  end

  index do
    selectable_column
    id_column
    column :name
    column :owned
    column :box
    column :cartridge
    column :manual
    column :pt_manual

    actions do |game|
      item 'Owned!', set_owned_admin_game_path(game), method: :patch, class: 'member_link'
      item 'No manual!', set_partial_admin_game_path(game), method: :patch, class: 'member_link'
    end
  end
end
