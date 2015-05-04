class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :created_at, :time, :location

  def created_at
    if object.updated_at > object.created_at
      return object.updated_at
    else
      return object.created_at
    end
  end
end
