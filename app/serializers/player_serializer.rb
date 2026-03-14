class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :just_name, :nickname, :name, :image, :country, :team

  def just_name
    object&.just_name
  end

  def country
    object&.country&.name
  end

  def team
    object&.team&.name
  end
end
