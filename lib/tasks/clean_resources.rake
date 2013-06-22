namespace :resources do
  desc "Deletes transient resources that were not updated in the last 48 hours"
  task :clean => :environment do
    transient_resources.each do |resource|
      delete_expired(resource)
    end
  end
  
  def transient_resources
    [Instance]
  end
  
  def delete_expired(resource)
    expired = resource.where("updated_at < ? ", 48.hours.ago)
    if expired.empty?
      puts "There are no expired #{resource}s to delete."
    else
      puts "Deleting #{resource}s with ids: #{expired.map(&:id).join(",")}"
      expired.delete_all
    end
  end
end