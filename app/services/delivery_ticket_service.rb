class DeliveryTicketService
	def initialize	
	end

	def self.transform file
	  invoices = Nokogiri::XML(file).css("Invoice").collect do |a|
	    {
	      GFMC: a.css("GFMC").text,
	      KPRQ: a.css("KPRQ").text,
	      FPHM: a.css("FPHM").text,
	      Detail: a.css("Detail").collect do |detail|
	        {
	          SPMC: detail.css("SPMC").text,
	          JLDW: detail.css("JLDW").text,
	          SL: detail.css("SL").text,
	        }
	      end
	    }
	  end
    
		book = Spreadsheet.open('app/assets/files/delivery_list_sample.xls')
  	sample_sheet = book.worksheet('sample')
  	new_sheet = book.worksheet('tickets')

  	total_rows, gap = 17, 0
  	init_row = 0
  	# binding.pry
  	invoices.each do |invoice|
  		invoice[:Detail].each_slice(6) do |invoice_details|
		  	active_row = init_row
	  		sample_sheet.rows[0..(total_rows-1)].each do |row|
		  		new_sheet.row(active_row).replace row
		  		row.formats.each_with_index do |format, format_index|
		  			new_sheet.row(active_row).set_format format_index, format
		  		end
		  		active_row += 1
		  	end

	  		new_sheet[init_row + 3, 1] = invoice[:GFMC]
	  		new_sheet[init_row + 3, 4] = Date.parse invoice[:KPRQ]
	  		new_sheet[init_row + 3, 6] = invoice[:FPHM]
	  		new_sheet.row(init_row + 3).height = 49.5

		  	new_sheet.merge_cells(init_row, 0, init_row, 6)
		  	new_sheet.merge_cells(init_row + 1, 0, init_row + 1, 6)
		  	new_sheet.merge_cells(init_row + 2, 0, init_row + 2, 6)
		  	new_sheet.merge_cells(init_row + 3, 4, init_row + 3, 5)
	  		#
		  	order_item_row = init_row + 5
		  	order_sum_row = init_row + 11
		  	order_sum = 0
		  	#
	  		invoice_details.each do |order_item|
	  			if order_item_row < order_sum_row
			  		new_sheet.row(order_item_row).replace ["", order_item[:SPMC], order_item[:JLDW], order_item[:SL].to_i]
				  	new_sheet.row(order_item_row).height = 18
			  		order_item_row += 1
			  		order_sum += order_item[:SL].to_i
			  	else
			  		p "#{invoice[:FPHM]}有超過六項"
			  	end
		  	end
		  	new_sheet[order_sum_row, 3] = order_sum
				new_sheet.row(order_item_row).height = 18
		  	init_row += total_rows + gap
		  end
	  end
	  # new_sheet.column(1).width = 55
	 	return book

    # book = Spreadsheet::Workbook.new
    # sheet = book.create_worksheet(name: "sheet1")
		# # 預設字型
		# wb.styles.fonts.first.name = '新細明體'
		# styles
		# text_center_hash = {:alignment => {:horizontal => :center, :vertical => :center}}
		# text_center = wb.styles.add_style(text_center_hash)
		# calibri = wb.styles.add_style( text_center_hash.merge({ sz: 10, font_name: "Calibri" }) )
		# 表格製作
		# wb.add_worksheet(:name => "sheet1") do |sheet|
	 #    sheet.add_row ['佛山市三角洲电器科技有限公司'], sz: 14, style: text_center
	 #    sheet.merge_cells("A1:G1")
	 #    sheet.add_row ['Foshan City San Jiao Zhou Electrical Technology Co.,Ltd'], style: calibri
	 #    sheet.merge_cells("A2:G2")
	 #    sheet.add_row ['送貨單'], sz: 20, style: text_center
	 #    # binding.pry
	 #    # sheet.rows.last.cells[0].fonts: "Calibri"
	 #    sheet.merge_cells("A3:G3")
	 #    sheet.add_row ['收貨單位:', '', '', '', '2017年4月17日'], sz: 12
	 #    sheet.merge_cells("E4:F4")
	 #    sheet.column_widths 21, 55, 14.2, 14.2
	 #  end
	 #  return p

	 #  data.each do |d|
	 #    kprq = Date.parse(d[:KPRQ])
	 #    csv << [ d[:GFMC], kprq.strftime("%Y"), kprq.strftime("%m"), kprq.strftime("%d") ]
	 #    2.times { csv << ["\n"] } # 公司名與貨品間隔兩行
	 #    d[:Detail].each do |detail|
	 #      csv << detail
	 #    end
	 #    if d[:Detail].size < 6
	 #      (6 - d[:Detail].size).times { csv << ["\n"] }
	 #    end
	 #    csv << ["", "", d[:Detail].map { |dd| dd[index_of_SL].to_i }.sum()]
	 #    csv << ["    佛山市三角洲电器科技有限公司"]
	 #    csv << ["\n"]
	 #    csv << ["         王小燕                       王小燕"]
	 #    2.times { csv << ["\n"] } # 送貨單之間間隔兩行
	 #  end
		# spreadsheet = StringIO.new
  #   book.write spreadsheet
  #   return spreadsheet
	end
end