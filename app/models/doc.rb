class Doc < ApplicationRecord
	scope :iso, -> { where(iso: true) }
	scope :normal, -> { where(iso: false) }

	validates :name, presence: { message: :blank }
	validates :code, uniqueness: true, allow_nil: true, allow_blank: true

	before_create :nilify_empty_values

	belongs_to :folder
	has_many :pins, :as => :pinnable

	def nilify_empty_values
		attributes.each do |column, value|
      self[column] = nil if self[column].kind_of? String and self[column].empty?
    end
	end

	def iso?
		self.iso
	end

	def normal?
		!self.iso
	end

	def public?
		self.public
	end

	def generate_oss_name
		file_ext = self.name[/\.[0-9a-z]+$/i]
		if file_ext.present?
			self.name.gsub(file_ext, "_" + self.created_at.strftime("%Y%m%d%H%M%S") + file_ext)
		else
			self.name + "_" + self.created_at.strftime("%Y%m%d%H%M%S")
		end
	end

	def index_url
		routes = Rails.application.routes.url_helpers
		routes.admin_folder_docs_path(folder_id: self.folder_id)
	end

	def office?
		self.name[/\.xls|\.xlsx|\.doc|\.docx|\.ppt|\.pptx$/i]
	end

	def preview_url
		self.office? ? self.office_online_url : self.download_url
	end

	def download_url timeout = 60
		OssService.new.download_url(self.oss_key, timeout)
	end

	def encode_download_url
		URI.encode(OssService.new.download_url(self.oss_key), /\W/)
	end

	def office_online_url
		"https://view.officeapps.live.com/op/view.aspx?src=" + self.encode_download_url
	end

	def office_embed_url
		"https://view.officeapps.live.com/op/embed.aspx?src=" + self.encode_download_url
	end
end