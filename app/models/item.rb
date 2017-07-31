class Item < ApplicationRecord
  mount_uploader :image, ItemImageUploader
  include ItemsImporter

  validates :name, presence: true

  belongs_to :department
  belongs_to :employee

  # def form_url
  #   self.persisted? ? item_path(self.token) : items_path
  # end

  def code
    "SJZ#{id.to_s.rjust(6,'0')}"
  end
end
