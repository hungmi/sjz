class DeliveryTicketService
	def initialize	
	end

	def self.transform file
		# book = Spreadsheet.open('app/assets/files/international_exp_sample.xls')
  	# sample_sheet = book.worksheet('INTERNATIONAL_EXP')
    # book = Spreadsheet::Workbook.new
    # sheet = book.create_worksheet(name: "sheet1")

	  data = Nokogiri::XML(file).css("Invoice").collect do |a|
	    {
	      GFMC: a.css("GFMC").text,
	      KPRQ: a.css("KPRQ").text,
	      Detail: a.css("Detail").collect do |detail|
	        [
	          detail.css("SPMC").text,
	          detail.css("JLDW").text,
	          detail.css("SL").text,
	        ]
	      end
	    }
	  end

		index_of_SL = 2 # 數量需加總，因此需要位置

		p = Axlsx::Package.new
		wb = p.workbook

		wb.add_worksheet(:name => "sheet1") do |sheet|
			# img = File.expand_path(ActionController::Base.helpers.asset_path('assets-cover2.jpg'), __FILE__)
			img = "#{Rails.root}/app/assets/images/assets-cover2.jpg"
	    sheet.add_image(:image_src => img, :noSelect => true, :noMove => true) do |image|
	      image.width=720
	      image.height=666
	      image.start_at 0, 0
	    end
	    sheet.add_row [1, 2, 3]
	    sheet.add_row ['     preserving whitespace']
	  end
	  return p

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