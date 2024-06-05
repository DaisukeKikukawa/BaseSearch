json.extract! union_team, :id, :name, :created_at, :updated_at
json.teams union_team.teams do |team|
  json.extract! team, :id, :name
end
json.url admin_union_team_url(union_team, format: :json)
