class Doc < ApplicationRecord
	scope :iso, -> { where(iso: true) }
	scope :normal, -> { where(iso: false) }

	validates :name, presence: true
	validates :name, :code, uniqueness: true

	has_many :pins, :as => :pinnable

	def iso?
		self.iso
	end

	def normal?
		!self.iso
	end

	def public?
		self.public
	end
end
