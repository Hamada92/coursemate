namespace :groups do 
  desc 'updates the status of the groups that ended in the last hour to completed'
  task mark_groups_completed: :environment do
    @count = Group.where("ends_at < ? AND status='active'", Time.zone.now).update_all(status: 'completed')
    Rails.logger.info "#{Time.zone.now}: marked #{@count} groups as completed "
  end
end

