json.success true
json.status 200
json.result do
  json.partial! 'api/v1/admin/users/show', locals: {user: @authenticated_admin}
  json.rest_token @authenticated_admin.rest_token
end