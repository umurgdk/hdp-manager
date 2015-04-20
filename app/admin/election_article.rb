ActiveAdmin.register ElectionArticle do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end

  form do |f|
    f.semantic_errors

    inputs 'Election Article' do
      input :title
      input :media_type, as: :select, collection: %w[image video]

      img_thumbnail = f.object.image.url(:thumbnail)
      img_big = f.object.image.url(:ios2x)
      input :image, as: :file, hint: (image_tag(img_thumbnail, admin_lightbox: img_big) if f.object.image.present?)

      input :video_url, as: :url
      input :body
    end

    f.actions
  end

  index do
    selectable_column

    column :title
    column :summary
    column :updated_at

    actions
  end

  show do |article|
    if article.media_type == 'image'
      img(src: article.image.url(:ios), admin_lightbox: article.image.url(:ios3x))
    elsif
      div(rel: article.video_url, class: 'video-player')
    end

    para(class: 'text-body') do
      article.body
    end
  end
end
