module EmployeesImporter
  extend ActiveSupport::Concern
  class_methods do
    def import_employees(file)
      book = Spreadsheet.open(file.path)
      # binding.pry
      sheet = book.worksheet('三角洲办公大楼通讯录')
      for i in 2..sheet.rows.size-1 do
        row = sheet.rows[i]
        puts "創建新人員#{row[2]}"
        if row[2].present?
          now_department = row[0].strip if row[0].present? && (row[0] != now_department)
          Employee.create! do |p|
              p.department = Department.find_or_create_by(name: now_department)
                   p.title = row[1].try(:strip)
                    p.name = row[2].try(:strip)
            p.mobile_phone = row[3].to_s[/[0-9]+/]
                     p.tel = row[4].to_s[/[0-9]+/]
                     p.ext = row[5].to_s[/[0-9]+/]
          end
        end
        i += 1
        # puts row
      end
    end
  end
end