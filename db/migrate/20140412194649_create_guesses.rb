class CreateGuesses < ActiveRecord::Migration
  def change
    create_table :guesses do |t|
      t.references :round, index: true
      t.integer :attempt
      t.references :player, index: true

      t.timestamps
    end
  end
end
