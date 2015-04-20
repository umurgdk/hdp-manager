class CreateElectionArticles < ActiveRecord::Migration
  def change
    create_table :election_articles do |t|
      t.string :title
      t.text :body
      t.string :media_type
      t.text :image_urls, default: [].to_yaml
      t.string :video_url

      t.timestamps null: false
    end
  end
end
