json.status 200
json.success true

json.partial! 'api/v1/users/show', locals: {user: user}