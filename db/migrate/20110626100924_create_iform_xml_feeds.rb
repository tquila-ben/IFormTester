class CreateIformXmlFeeds < ActiveRecord::Migration
  def self.up
    create_table :iform_xml_feeds do |t|
      t.text :body
      t.text :header
      t.integer :record_count

      t.timestamps
    end
  end

  def self.down
    drop_table :iform_xml_feeds
  end
end
