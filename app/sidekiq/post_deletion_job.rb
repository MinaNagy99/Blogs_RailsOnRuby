class PostDeletionJob
  include Sidekiq::Job

  def perform(*args)
    puts "Running post deletion"
    Article.where('created_at <= ?', 24.hours.ago).destroy_all
  end
end
