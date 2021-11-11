class CreateInvolvedCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :involved_companies do |t|
      t.boolean :developer, default: false
      t.boolean :publisher, default: false
      t.references :game, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end

    add_index :involved_companies, %i[game_id company_id], unique: true
  end
end
