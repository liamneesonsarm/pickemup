FactoryGirl.define do
  factory :user do
    github_uid    { generate(:guid) }
    linkedin_uid  { generate(:guid) }
    email         { Faker::Internet.email }
    name          { Faker::Name.name }
    location      { "#{Faker::Address.city}, #{Faker::AddressUS.state}" }
    main_provider 'github'
    profile_image { Faker::Internet.http_url }
    description   { Faker::Lorem.sentences.join(' ') }
  end

  factory :conversation do
    job_listing
    subject { Faker::Lorem.sentences.join(' ') }
  end

  factory :tech_stack do
    company
    name                { Faker::Name.name }
    back_end_languages  { PreferenceConstants::BACK_END_LANGUAGES.shuffle[0..1] }
    front_end_languages { PreferenceConstants::FRONT_END_LANGUAGES.shuffle[0..1] }
    frameworks          { PreferenceConstants::FRAMEWORKS.shuffle[0..1] }
    dev_ops_tools       { PreferenceConstants::DEV_OPS_TOOLS.shuffle[0..1] }
  end

  factory :job_listing do
    company
    job_title               { Faker::Lorem.word }
    job_description         { Faker::Lorem.sentences.join(' ') }
    salary_range_high       100000
    salary_range_low        50000
    vacation_days           15
    equity                  JobListing::EQUITY_SELECTIONS.shuffle.first
    bonuses                 JobListing::BONUS_SELECTIONS.shuffle.first
    remote                  false
    hiring_time             2
    locations               PreferenceConstants::LOCATIONS.shuffle[0..2]
    sponsorship_available   true
    estimated_work_hours    40
    active                  true
    experience_levels       PreferenceConstants::EXPERIENCE_LEVELS.shuffle[0..2]
    perks                   PreferenceConstants::PERKS.shuffle[0..2]
    practices               PreferenceConstants::PRACTICES.shuffle[0..2]
    special_characteristics [PreferenceConstants::SPECIAL_CHARACTERISTICS.shuffle.first]
    position_titles         PreferenceConstants::POSITION_TITLES.shuffle[0..1]
    acceptable_languages    PreferenceConstants::ACCEPTABLE_LANGUAGES.shuffle[0..2]
    trait :unsponsored do
      sponsorship_available false
    end
    trait :inactive do
      active false
    end
    trait :remote do
      remote true
    end
    trait :full_benefits do
      healthcare true
      dental true
      vision true
      life_insurance true
      retirement true
    end
    trait :parttime do
      fulltime false
    end
  end

  factory :company do
    name          { Faker::Company.name }
    email         { Faker::Internet.email }
    password      'thisisapassword'
    description   { Faker::Lorem.sentences.join(' ') }
    website       { Faker::Internet.http_url }
    industry      { Faker::Lorem.word }
    num_employees 10
  end

  factory :subscription do
    company
    plan                  2
    email                 { Faker::Internet.email }
    active                true
    stripe_customer_token { generate(:guid) }
    stripe_card_token     { generate(:guid) }
    trait :inactive do
      active false
    end
  end

  factory :github_account do
    user
    nickname           { Faker::Name.name }
    hireable           true
    bio                { Faker::Lorem.sentences.join(' ') }
    public_repos_count 10
    number_followers   10
    number_following   10
    number_gists       10
    blog               { Faker::Internet.http_url }
    token              { generate(:guid) }
    github_account_key { generate(:guid) }
    uid                { generate(:guid) }
  end

  factory :education do
    profile
    activities     { Faker::Lorem.sentences.join(' ') }
    degree         { Faker::Education.degree }
    field_of_study { Faker::Education.major }
    notes          { Faker::Lorem.sentences.join(' ') }
    school_name    { Faker::Education.school_name }
    start_year     { '2013' }
    end_year       { '2018' }
    education_key  { generate(:guid) }
  end

  factory :profile do
    linkedin
    number_connections  10
    number_recommenders 10
    summary             { Faker::Lorem.sentences.join(' ') }
    skills              ['Ruby', 'Ruby on Rails']
  end

  factory :linkedin do
    user
    token       { generate(:guid) }
    headline    { Faker::Lorem.sentence }
    industry    { Faker::Lorem.word }
    uid         { generate(:guid) }
    profile_url { Faker::Internet.http_url }
  end

  factory :organization do
    github_account
    name               { Faker::Name.name }
    logo               { Faker::Lorem.word }
    url                { Faker::Internet.http_url }
    organization_key   { generate(:guid) }
    location           { "#{Faker::Address.city}, #{Faker::AddressUS.state}" }
    number_followers   10
    number_following   10
    blog               { Faker::Internet.http_url }
    public_repos_count 10
    company_type       { Faker::Lorem.word }
  end

  factory :position do
    profile
    industry     { Faker::Lorem.word }
    company_type { Faker::Lorem.word }
    name         { Faker::Company.name }
    size         '201-500 employees'
    position_key { generate(:guid) }
    is_current   true
    title        { Faker::Company.position }
    summary      { Faker::Lorem.sentences.join(' ') }
    start_year   '2012'
    start_month  '7'
  end

  factory :repo do
    github_account
    name           { Faker::Name.name }
    description    { Faker::Lorem.sentences.join(' ') }
    url            { Faker::Internet.http_url }
    language       'Ruby'
    number_forks    5
    number_watchers 5
    size            50
    open_issues     4
    started         Date.yesterday
    last_updated    Date.today
    repo_key        { generate(:guid) }
  end

  factory :stackexchange do
    user
    token             { generate(:guid) }
    uid               { generate(:guid) }
    profile_url       { Faker::Internet.http_url }
    reputation        100
    age               42
    badges            { { 'gold' => '0', 'bronze' => '0', 'silver' => '0' } }
    display_name      { Faker::Name.name }
    nickname          { Faker::Name.name }
    stackexchange_key { generate(:guid) }
  end

  factory :preference do
    user
  end

  factory :interview do
    user_id        { create(:user).id }
    company_id     { create(:company).id }
    job_listing_id { create(:job_listing).id }
    request_date   5.days.from_now
    status         :pending
    description    { Faker::Lorem.sentences.join(' ') }
    duration       5
    location       { "#{Faker::Address.city}, #{Faker::AddressUS.state}" }

    trait :hireable do
      hireable true
    end

    trait :unhireable do
      hireable false
    end
  end
end
