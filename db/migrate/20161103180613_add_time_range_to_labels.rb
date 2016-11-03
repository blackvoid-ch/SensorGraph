class AddTimeRangeToLabels < ActiveRecord::Migration[5.0]
  def change
    add_column :labels, :time_range, :string, :null => false, :default => "default"
  end
end
