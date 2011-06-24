class CreateIformXmlPosts < ActiveRecord::Migration
  def self.up
    create_table :iform_xml_posts do |t|
      t.text :body
      t.text :header

      t.timestamps
    end
  end

  def self.down
    drop_table :iform_xml_posts
  end
end
