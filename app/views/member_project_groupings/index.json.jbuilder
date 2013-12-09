json.array!(@member_project_groupings) do |member_project_grouping|
  json.extract! member_project_grouping, :id, :id, :m_id, :p_id
  json.url member_project_grouping_url(member_project_grouping, format: :json)
end
