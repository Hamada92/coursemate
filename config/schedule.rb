# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, "/var/www/coursemate/shared/log/cron_log.log"

if ENV['RAILS_ENV'] == 'production'
  job_type :rake,    "cd :path && :environment_variable=:environment /home/ahmad/.rbenv/shims/bundle exec rake :task --silent :output"
end

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

every 1.hour do 
  rake "groups:mark_groups_completed"
end
