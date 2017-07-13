class Doc < ApplicationRecord
	scope :iso, -> { where(iso: true) }
	scope :normal, -> { where(iso: false) }

	validates :name, presence: true
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

	def oss_name
		self.oss_key + self.name[/\.[0-9a-z]+$/i]
	end

	def index_url
		routes = Rails.application.routes.url_helpers
		self.normal? ? routes.admin_docs_path : routes.admin_iso_docs_path
	end
end
