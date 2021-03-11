class AddFieldsToNotification < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :type_notification, :string
    add_column :notifications, :visualized, :boolean, default: false
  end
end
