class AddTimeModeToLabels < ActiveRecord::Migration[5.0]
  def change
    add_column :labels, :time_mode, :integer, :null => false, :default => 0
  end
end
