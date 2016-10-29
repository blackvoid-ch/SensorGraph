class CreateLabels < ActiveRecord::Migration[5.0]
  def change
    create_table :labels do |t|
      t.string :title
      t.references :sensor, foreign_key: true

      t.timestamps
    end
  end
end
