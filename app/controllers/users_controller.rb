class UsersController < ApplicationController
  before_filter :eager_load_user, only: [:resume]
  before_filter :get_and_check_user, only: [:preferences, :get_preference, :update_preference]
  before_filter :cleanup_preference_params, only: [:update_preference]
  respond_to :json, :html

  def resume
    if @user
      @github_account = @user.github_account
      @repos          = @github_account.repos
      @orgs           = @github_account.organizations
      @stackexchange  = @user.stackexchange
      @linkedin       = @user.linkedin
      if @linkedin
        @profile      = @linkedin.profile
        @positions    = @profile.positions
        @educations   = @profile.educations
        @skills       = @profile.skills
      end
    end
  end

  def preferences
  end

  def get_preference
    preference = @user.preference
    respond_with preference.get_preference_defaults
  end

  def update_preference
    preference = @user.preference
    if preference.update_attributes(@bathed_preferences)
      respond_with(preference)
    else
      render json: { errors: preference.errors }, status: :bad_request
    end
  end

  private

  def eager_load_user
    @user ||= User.includes(
      stackexchange: [],
      github_account: [:repos, :organizations],
      linkedin: {profile: [:positions, :educations]}
    ).find(params[:id]) #eager load all user information
  end

  def cleanup_preference_params
    @bathed_preferences = Preference.cleanup_invalid_data(params[:preference])
  end
end
