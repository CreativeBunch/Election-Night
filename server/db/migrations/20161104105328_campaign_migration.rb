class CampaignMigration < ActiveRecord::Migration[5.0]
  def change
    create_table :campainss do |t|
      t.string  :name
      t.integer :candidate_a_id
      t.integer :candidate_b_id
      t.integer :winner_candidate_id
      t.timestamps null:  true
    end
  end
end
