namespace :cron do
  desc "Test cron job works or not"
  task :check_cron_job_works => :environment do
    puts "#{Time.now} Cron Job works *( ^ 3 ^ )*y "
  end

  desc "Clean tmp files"
  task :clean_tmp => :environment do
  	# TODO
  end
end