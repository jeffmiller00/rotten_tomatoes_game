class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.string :movie
      t.integer :score
      t.references :game, index: true

      t.timestamps
    end
  end
end
