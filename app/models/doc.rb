class Doc < ApplicationRecord
	scope :iso, -> { where(iso: true) }
	scope :normal, -> { where(iso: false) }

	validates :name, presence: { message: :blank }
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
		file_ext = self.name[/\.[0-9a-z]+$/i]
		self.name.gsub(file_ext, "_" + self.updated_at.strftime("%Y%m%d%H%M%S") + file_ext)
	end

	def index_url
		routes = Rails.application.routes.url_helpers
		self.normal? ? routes.admin_docs_path : routes.admin_iso_docs_path
	end

	def office?
		self.name[/\.xls|\.xlsx|\.doc|\.docx|\.ppt|\.pptx$/i]
	end

	def preview_url
		self.office? ? self.office_online_url : self.download_url
	end

	def download_url timeout = 60
		OssService.new.download_url(self.oss_name, timeout)
	end

	def encode_download_url
		URI.encode(OssService.new.download_url(self.oss_name), /\W/)
	end

	def office_online_url
		"https://view.officeapps.live.com/op/view.aspx?src=" + self.encode_download_url
	end

	def office_embed_url
		 "https://view.officeapps.live.com/op/embed.aspx?src=" + self.encode_download_url
	end
end
