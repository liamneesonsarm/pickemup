class LinkedinWorker
  include Sidekiq::Worker

  def perform(linkedin_id)
    linkedin = Linkedin.find_by_id(linkedin_id)
    return if linkedin.blank?
    profile = linkedin.get_profile
    linkedin.build_profile.from_omniauth(profile)
  end
end
