class TeamPlayerSerializer < ActiveModel::Serializer
  attributes :id, :just_name, :nickname, :name, :image, :country

  def just_name
    object&.just_name
  end

  def country
    object&.country&.name
  end
end
