class Admin::Finance::TicketsController < AdminController
	def uploading
	end

	def transform
		file = params[:tickets_xml_file]
		new_file_name = "#{file.original_filename.gsub('.xml', '')}_tickets.xls"
		new_file = DeliveryTicketService.transform file
		# new_file.serialize "tmp/#{new_file_name}"
		new_file.write "tmp/#{new_file_name}"
		send_file "#{Rails.root}/tmp/#{new_file_name}", filename: new_file_name, type: "application/xls"
		# flash[:success] = "轉換成功。"
		# redirect_to admin_finance_tickets_uploading_url
	end
end