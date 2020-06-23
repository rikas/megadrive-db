class Game < ApplicationRecord
  enum box: %i[no_box box_md_eu box_md_jp box_genesis]
  enum cartridge: %i[no_cart cart_md_eu cart_md_jp cart_genesis]
  enum manual: %i[no_manual manual_md_eu manual_md_jp manual_genesis]

  scope :sorted, -> { order("UPPER(name) ASC") }
  scope :owned, -> { where(owned: true) }
  scope :not_owned, -> { where(owned: false) }

  def status
    return :none if !owned?

    return :partial if owned? && !full_eu?

    :full
  end

  def full_eu?
    box_md_eu? && cart_md_eu? && manual_md_eu?
  end
end
