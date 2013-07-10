# == Schema Information
#
# Table name: repos
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  description       :text
#  private           :boolean
#  url               :string(255)
#  language          :string(255)
#  number_forks      :integer
#  number_watchers   :integer
#  size              :integer
#  open_issues       :integer
#  started           :datetime
#  last_updated      :datetime
#  repo_key          :string(255)
#  github_account_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class Repo < ActiveRecord::Base
  belongs_to :github_account

  def self.from_omniauth(repos, github_id)
    repos.each do |repo|
      found_repo = Repo.find_or_initialize_by_repo_key_and_github_account_id(repo.id.to_s, github_id)
      found_repo.update_attributes(
        name:            repo.name,
        description:     repo.description,
        private:         repo.private,
        url:             repo.html_url,
        language:        repo.language,
        number_forks:    repo.forks,
        number_watchers: repo.watchers,
        size:            repo.size,
        open_issues:     repo.open_issues_count,
        started:         repo.created_at,
        last_updated:    repo.updated_at
      )
    end
  end
end
