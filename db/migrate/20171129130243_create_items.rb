class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items, id: :uuid do |t|
      t.decimal :price
      t.references :user, foreign_key: true, type: :uuid
      t.references :transaction, foreign_key: true, type: :uuid
      t.references :article, foreign_key: true, type: :uuid
      t.references :amount, foreign_key: true, :default => 1
      t.timestamps
    end
  end
end
