class Doc < ApplicationRecord
	scope :iso, -> { where(iso: true) }
	scope :normal, -> { where(iso: false) }

	validates :name, presence: true, uniqueness: true
	validates :code, uniqueness: true, allow_nil: true

	has_secure_token :oss_key

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
