pickemup.controller("UsersController", ['$scope', '$location', '$state', '$stateParams', 'User', 'Home', ($scope, $location, $state, $stateParams, User, Home) ->

  angular.extend $scope,
    user:           {}
    original:       {}
    errors:         []
    success:        ''
    error_updating: ''
    dirty_message:  ''

  if $state.current.name == 'user_edit'
    User.get
      id: $stateParams['id'],
      action: 'edit'

    , (response) ->
      $scope.user = response
      $scope.original = angular.copy($scope.user)
    , (response) ->
      $scope.error_updating = 'There were issues updating your information.'

  else if $state.current.name == 'user'
    angular.extend $scope,
      locations: ['San Francisco, CA', 'Portland, OR', 'Seattle, WA',
                  'New York City, NY', 'Chicago, IL', 'Boston, MA',
                  'Austin, TX', 'Los Angeles, CA', 'Cincinnati, OH']
      selectedLocations: []
    Home.get
      action: 'get_matches'
    , (response) ->
      $scope.job_listings = response.job_listings
      $scope.user_id = response.user_id
      $scope.retainedMatches = angular.copy($scope.job_listings)

  angular.extend $scope,
    maintainSelectedLocations: (location) ->
      if _.contains($scope.selectedLocations, location)
        $scope.selectedLocations = _.filter $scope.selectedLocations, (selectedLocation) ->
          selectedLocation != location
      else
        $scope.selectedLocations.push location

    clearFilters: ->
      $scope.searchLanguage = null
      $scope.selectedLocations = []
      $scope.clearSalaryBetween()
      return

    update: ->
      User.update
        id: $stateParams['id'],
        action: '',
        user:
          name: $scope.user.name
          email: $scope.user.email
          location: $scope.user.location
          description: $scope.user.description

      , (response) ->
        $scope.user.errors    = []
        $scope.success        = 'Successfully updated your profile information.'
        $scope.error_updating = ''
        $scope.dirty_message  = ''
        $scope.original       = angular.copy($scope.user)

      , (response) ->
        $scope.user.errors    = response['data']['errors']
        $scope.error_updating = 'Unable to update your profile. See specific error messages below.'
        $scope.success        = ''

  $scope.$watch 'user', ( ->
    if angular.equals($scope.user, $scope.original)
      $scope.dirty_message = ''
    else
      $scope.success = ''
      $scope.dirty_message = 'You have made changes, make sure to click the \'Save\' button below.'
  ), true
])
