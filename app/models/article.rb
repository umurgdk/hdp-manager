require 'loofah/helpers'

class Article < ActiveRecord::Base
  has_attached_file :image, styles: {
    thumbnail: '128x128>',
    ios: '320x200>',
    ios2x: '640x400>',
    ios3x: '1125x600>'
  }

  validates_attachment_content_type :image, content_type: ['image/jpg', 'image/jpeg', 'image/png']

  def summary
    doc = Loofah.fragment(body.gsub(/[\r\n]/, ''))
    doc.text.truncate_words(14)
  end

  def image_url
    image.url(:thumbnail)
  end

  def image_url_ios
    image.url(:ios)
  end

  def image_url_ios2x
    image.url(:ios2x)
  end

  def image_url_ios3x
    image.url(:ios3x)
  end
end
