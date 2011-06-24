class CreateIformTestResponses < ActiveRecord::Migration
  def self.up
    create_table :iform_test_responses do |t|
      t.integer :iform_test_id
      t.text :header
      t.text :body
      t.string :request_via
      t.datetime :sent_at
      t.string :profile_code

      t.timestamps
    end
  end

  def self.down
    drop_table :iform_test_responses
  end
end
