json.success true
json.status 200
json.result do
  json.partial! 'api/v1/users/show', locals: {user: user}
  json.rest_token user.rest_token
end