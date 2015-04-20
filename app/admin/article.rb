ActiveAdmin.register Article do
  permit_params :image, :body, :title, :category

  form html: { enctype: 'multipart/form-data' } do |f|
    f.semantic_errors

    f.inputs 'Article' do
      f.input :title
      f.input :category

      img_thumbnail = f.object.image.url(:thumbnail)
      img_big = f.object.image.url(:ios2x)

      f.input :image, as: :file, hint: image_tag(img_thumbnail, admin_lightbox: img_big)
      f.input :body, as: :wysihtml5
    end

    f.actions
  end

  index do
    selectable_column

    column :image do |article|
      link_to image_tag(article.image.url(:thumbnail)), admin_article_path(article)
    end

    column :category
    column :title
    column :summary

    actions
  end

end
