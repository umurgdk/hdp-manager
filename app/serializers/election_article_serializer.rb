class ElectionArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :media_type, :image_url, :video_url, :created_at

  def image_url
    if scope == :ios
      return object.image_url_ios
    elsif scope == :ios2x
      return object.image_url_ios2x
    elsif scope == :ios3x
      return object.image_url_ios3x
    end

    object.image_url
  end

  def created_at
    if object.updated_at > object.created_at
      return object.updated_at
    else
      return object.created_at
    end
  end
end
