class CreateProviders < ActiveRecord::Migration[5.2]
  def change
    create_table :providers do |t|
      t.string :name
      t.string :uid
      t.references :user, foreign_key: true
    end
  end
end
