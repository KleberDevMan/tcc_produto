# == Schema Information
#
# Table name: notifications
#
#  id                :bigint           not null, primary key
#  description       :string
#  title             :string
#  type_notification :string
#  visualized        :boolean          default(FALSE)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :bigint           not null
#
# Indexes
#
#  index_notifications_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Notification < ApplicationRecord
  belongs_to :user

  extend Enumerize
  enumerize :type_notification, in: [:new_collaboration, :quit_collaboration, :edit_collaboration_admin], predicates: true

  scope :not_viewed, -> { where(visualized: false) }

  def self.create_notification(type, idea)
    type = type.to_sym
    user = idea.ideializer

    attr = { user_id: user.id, type_notification: type }

    case type
    when :new_collaboration
      attr.merge!({ title: 'Novo colaborador',
                   description: "Sua ideia: #{idea.title.truncate(60)} acaba de receber um novo colaborador: #{user.name}" })
    when :quit_collaboration
      attr.merge!({ title: 'Desistiu da colaboração',
                   description: "O colaborador #{user.name} desistiu de colaborar com sua ideia: #{idea.title.truncate(60)}" })
    else
      attr.merge!({ title: 'Lista de colaboradores atualizada',
                   description: "Da uma olhadinha na sua ideia: #{idea.title.truncate(80)}. Ela acaba de ter a lista de colaboradores atualizada!" })
    end

    Notification.create!(attr)
  end
end
