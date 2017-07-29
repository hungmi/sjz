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

	def new_breadcrumb folder, options = {}
		if folder.id != 1
			active_folder = options[:link_to_active] ? folder.breadcrumb : folder.name
			path = []
			while folder.parent.present? do
				folder = folder.parent
				path << folder.name unless folder.id == 1
			end
			divider = "<span style='font-size: 16px;'>/</span>"
			breadcrumb = "<span class='path-name'>#{divider} "
			path.reverse.each do |p|
				breadcrumb += Folder.find_by_name(p).breadcrumb + " #{divider} "
			end
			breadcrumb += "#{active_folder}</span>"
			return breadcrumb.html_safe
		end
	end
end
