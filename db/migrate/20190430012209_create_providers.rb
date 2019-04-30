class CreateProviders < ActiveRecord::Migration[5.2]
  def change
    create_table :providers do |t|
      t.string :name
      t.uid :name
      t.references :user, foreign_key: true
    end
  end
end
