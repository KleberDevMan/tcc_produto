class AddImgOrLinkToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :img_link, :string
    add_column :users, :img, :string
    add_column :users, :link_or_img, :string
  end
end
