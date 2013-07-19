module PreferenceConstants
  extend ActiveSupport::Concern

  LOCATIONS     = ['San Francisco, CA', 'Portland, OR', 'Seattle, WA',
                   'New York City, NY', 'Chicago, IL', 'Boston, MA',
                   'Austin, TX', 'Los Angeles, CA', 'Cincinnati, OH']

  INDUSTRIES    = ['Medical', 'Mobile', 'Education', 'Entertainment', 'Advertising', 'Scientific', 'Consumer Technology',
                   'Security', 'Transportation', 'Banking', 'Real Estate', 'Legal', 'Industrial', 'Gaming', 'Food',
                   'Fitness', 'Sports', 'Architecture', 'Agriculture', 'Art', 'Hardware', 'Non-profit']

  LEVELS        = ['Intern', 'Co-op', 'Junior Engineer', 'Mid-level Engineer', 'Senior-level Engineer', 'Executive']

  POSITIONS     = ['Associative Engineer', 'Software Engineer', 'DevOps Engineer', 'Senior Engineer', 'Staff Engineer', 'Engineering Manager',
                   'Principal Engineer', 'Senior Principal Engineer', 'Senior Engineering Manager', 'Architect', 'Director of Engineering',
                   'Senior Architect', 'Senior Director of Engineering', 'VP of Engineering', 'SVP of Engineering']

  SETTINGS      = ['Urban', 'Rural', 'Office Park']

  DRESS_CODES   = ['Professional', 'Business Casual', 'Casual']

  COMPANY_TYPES = ['Bootstrapped', 'VC Backed', 'Small Business', 'Publicly-Owned Business']

  PERKS         = ['Kegs', 'Ping-pong table', 'Snacks', 'Catered Meals', 'Offsites', 'Flexible Work Hours', 'Conference Travel',
                   'Work from Home', 'Lunch Stipend', 'Phone Stipend', 'Public Transit Stipend', 'Tuition Reimbursement', 'Choice of Equipment',
                   'Swag']

  PRACTICES     = ['Test-driven Development', 'Agile Development', 'Pair Programming', 'Behavior-driven Development', 'Scrum',
                   'Cowboy Coding', 'Object Oriented Design', 'Waterfall Model', 'Service-oriented Design', 'Don\'t Repeat Yourself (DRY)',
                   'Extreme Programming', 'Continuous Integration']

  REMOTE        = {0 => "No", 1 => "Yes", 2 => "I'm open to remote work"}

  COMPANY_SIZE  = {0 => "1-10 Employees", 1 => "11-50 Employees", 2 => "51-200 Employees", 3 => "201-500 Employees", 4 => "501+ Employees"}
end