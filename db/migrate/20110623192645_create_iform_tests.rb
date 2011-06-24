class CreateIformTests < ActiveRecord::Migration
  def self.up
    create_table :iform_tests do |t|
      t.integer :iform_xml_feed_id
      t.integer :iform_xml_post_id
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :iform_tests
  end
end
