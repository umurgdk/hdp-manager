class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :category, :body, :summary, :image_url

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
end
