class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions, id: :uuid do |t|
      t.string :name
      t.references :user, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
