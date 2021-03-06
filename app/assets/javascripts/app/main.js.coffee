@pickemup = angular.module('Pickemup', [
  'ngResource',
  'ui.router.compat',
  'csrf',
  'utf8',
  'message-threshold',
  'ck-editor',
  'salary-between',
  'skillUserSearch',
  'languageCompanySearch',
  'locationSearch',
  'ngSanitize',
  'attributeArrayLimit',
  'message-threshold'
])

@chunk = (a,s) ->
  if a
    if a.length == 0
      []
    else
      ( a[i..i+s-1] for i in [0..a.length - 1 ] by s)

@unchunk = (a) ->
  merged = []
  merged.concat.apply(merged, a)

#Convert string into a money format with commas 60000 -> 60,000
@addCommas = (nStr) ->
  nStr += ""
  x = nStr.split(".")
  x1 = x[0]
  x2 = (if x.length > 1 then "." + x[1] else "")
  rgx = /(\d+)(\d{3})/
  x1 = x1.replace(rgx, "$1" + "," + "$2")  while rgx.test(x1)
  x1 + x2

@changeLocation = (scope, location, url, forceReload) ->
  $scope = $scope or angular.element(document).scope()
  if forceReload or $scope.$$phase
    window.location = url
  else
    $location.path(url)
    $scope.$apply()
