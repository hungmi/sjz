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

	def new_breadcrumb folder
		if folder.id != 1
			active_folder_name = folder.name
			path = []
			while folder.parent.present? do
				folder = folder.parent
				path << folder.name unless folder.id == 1
			end
			breadcrumb = "<span class='path-name'>> "
			path.reverse.each do |p|
				breadcrumb += Folder.find_by_name(p).breadcrumb + " > "
			end
			breadcrumb += "#{active_folder_name}</span>"
			return breadcrumb.html_safe
		end
	end
end
