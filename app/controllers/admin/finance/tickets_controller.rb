class Admin::Finance::TicketsController < AdminController
	def uploading
	end

	def transform
		file = params[:tickets_xml_file]
		new_file_name = "#{file.original_filename.encode("gbk").gsub('.xml', '')}_tickets.xls"
		new_file = DeliveryTicketService.transform file
		new_file.write "tmp/#{new_file_name}"
		send_file "#{Rails.root}/tmp/#{new_file_name}", filename: new_file_name, type: "application/xls"
	end
end