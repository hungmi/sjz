class Folder < ApplicationRecord
	has_many :docs
	belongs_to :parent, class_name: "Folder", required: false
	has_many :children, class_name: "Folder", foreign_key: "parent_id"

	validates :name, presence: true, uniqueness: true

	# def breadcrumb
	# 	routes = Rails.application.routes.url_helpers
	# 	"<li><a href='#{routes.admin_folder_docs_path(folder_id: self.id)}'>#{self.name}</a></li>"
	# end

	def breadcrumb
		routes = Rails.application.routes.url_helpers
		"<a href='#{routes.admin_folder_docs_path(folder_id: self.id)}'>#{self.name}</a>"
	end
end
