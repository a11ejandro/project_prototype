json.status status.present? ? status : 400
json.success false
json.result result || 'An error has occured'