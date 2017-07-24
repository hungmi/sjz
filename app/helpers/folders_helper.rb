module FoldersHelper
	def breadcrumb folder
		active_folder_name = folder.name
		path = []
		while folder.parent.present? do
			folder = folder.parent
			path << folder.name
		end
		breadcrumb = "<ol class='breadcrumb'>"
		path.reverse.each do |p|
			breadcrumb += Folder.find_by_name(p).breadcrumb
		end
		breadcrumb += "<li class='active'>#{active_folder_name}</li></ol>"
		return breadcrumb.html_safe
	end
end
