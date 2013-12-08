json.array!(@projects) do |project|
  json.extract! project, :id, :name, :expected_due_date, :manager_id
  json.url project_url(project, format: :json)
end
