json.success true
json.status 200

json.result do
  json.users @users do |user|
    json.partial! 'api/v1/admin/users/show', locals: {user: user}
  end

  json.pagination do
    json.page @page
    json.total_pages @total_pages
  end
end