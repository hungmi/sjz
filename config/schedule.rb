# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
env :PATH, ENV['PATH']
set :output, "log/cron.log"
every 1.day, :at => "#{(Time.now + 2.minute).strftime("%H:%M %P")}" do
  rake "cron:check_cron_job_works"
end

# every 1.day, :at => "00:30 am" do
#   rake "dev:backup"
# end

# every 1.days, :at => "00:00 am" do
#   rake "cron:update_jpy_currency"
# end
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
