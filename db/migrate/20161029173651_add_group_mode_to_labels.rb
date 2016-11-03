class AddGroupModeToLabels < ActiveRecord::Migration[5.0]
  def change
    add_column :labels, :group_mode, :string, :null => false, :default => "default"
  end
end
