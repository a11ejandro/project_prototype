json.status 200
json.success true

json.result do
  json.partial! 'api/v1/admin/users/show', locals: {user: user}
end