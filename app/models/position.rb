# == Schema Information
#
# Table name: positions
#
#  id           :integer          not null, primary key
#  industry     :string(255)
#  company_type :string(255)
#  name         :string(255)
#  size         :string(255)
#  company_key  :string(255)
#  is_current   :boolean
#  title        :string(255)
#  summary      :text
#  start_year   :string(255)
#  start_month  :string(255)
#  profile_id   :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Position < ActiveRecord::Base
  belongs_to :profile

  def self.from_omniauth(profile, id)
    if profile['positions'].present?
      profile['positions']['values'].each do |position|
        company_info = position['company']
        pos = Position.find_or_initialize_by_company_key_and_profile_id(company_info['id'].to_s, id)
        pos.update_attributes(
          industry:      company_info['industry'],
          company_type:  company_info['type'],
          name:          company_info['name'],
          size:          company_info['size'],
          company_type:  company_info['type'],
          is_current:    position['isCurrent'],
          start_year:    position['startDate']['year'],
          start_month:   position['startDate']['month'],
          summary:       position['summary'],
          title:         position['title']
        )
      end
    end
  end
end
