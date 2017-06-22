module ItemsImporter
  extend ActiveSupport::Concern
  class_methods do
    def import_items(file)
      # NOTE 每個財產都會有一個使用人（不可為部門，請設為該部門主管），跟一個使用部門。
      book = Spreadsheet.open(file.path)
      # binding.pry
      sheet = book.worksheet('二期8座801')
      for i in 1..sheet.rows.size-1 do
        row = sheet.rows[i]
        puts "創建新財產#{row[3]}"
        if row[3].present?
          now_location = row[1].strip if row[1].present? && (row[1] != now_location)
          now_department = row[7].strip if row[7].present? && (row[7] != now_department)
          now_employee = row[8].strip if row[8].present? && (row[8] != now_employee)
          Item.create! do |p|
              # TODO 加入 location 之後再匯入
              # p.location = Location.find_or_create_by(name: now_location)
            p.department = Department.find_or_create_by(name: now_department)
              p.employee = Employee.find_or_create_by(name: now_employee)
                  p.name = row[3].to_s.try(:strip)
                  p.spec = row[4].to_s.try(:strip)
                  p.unit = row[5].to_s.try(:strip)
              p.quantity = row[6].to_i.to_s.try(:strip)#.to_s[/[0-9]+/]
          end
        end
        i += 1
        # puts row
      end
    end
  end
end