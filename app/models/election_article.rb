class ElectionArticle < ActiveRecord::Base
  has_attached_file :image,
                    styles: {thumbnail: '128x128>', ios: '320x200>', ios2x: '640x400>', ios3x: '1125x600>'},
                    :convert_options => {
                      thumbnail: '-background black -gravity center -extent 128x128',
                      ios: '-background black -gravity center -extent 320x200',
                      ios2x: '-background black -gravity center -extent 640x400',
                      ios3x: '-background black -gravity center -extent 1125x600',
                    }

  validates_attachment_content_type :image, content_type: %w(image/jpg image/jpeg image/png)

  def summary
    # full_sanitizer.sanitize(body).truncate_wors(14)
    body.strip.truncate_words(15)
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
