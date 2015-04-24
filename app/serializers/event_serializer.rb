class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :created_at, :time, :location
end
