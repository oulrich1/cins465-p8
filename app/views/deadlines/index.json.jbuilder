json.array!(@deadlines) do |deadline|
  json.extract! deadline, :id, :members_id, :projects_id, :description, :due_date
  json.url deadline_url(deadline, format: :json)
end
