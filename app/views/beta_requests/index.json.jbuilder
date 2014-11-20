json.array!(@beta_requests) do |beta_request|
  json.extract! beta_request, :id, :email
  json.url beta_request_url(beta_request, format: :json)
end
