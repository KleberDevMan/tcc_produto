class AddLinkOrImgToIdeaCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :idea_categories, :link_or_image, :string
  end
end
