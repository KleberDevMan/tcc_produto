# #inicia transacao
# ActiveRecord::Base.transaction do
#   begin
#
#     Menu.destroy_all
#     ActiveRecord::Base.connection.reset_pk_sequence!('menus')
#     Menu.create([
#                   # Mural de ideias
#                   { name: I18n.t('texts.idea.wall_of_ideas'), url: '/ideas', active: true, icon: 'fe-home' },
#
#                   # Mural de trabalhos
#                   { name: I18n.t('activerecord.models.teachers'), url: '/teachers', active: true, icon: 'fe-users' },
#                   { name: I18n.t('activerecord.models.courses'), url: '/courses', active: true, icon: 'fe-tv' },
#                   { name: I18n.t('activerecord.models.academic_works'), url: '/academic_works', active: true, icon: 'fe-file-text' },
#
#                   # Depósito de ideias
#                   { name: I18n.t('activerecord.models.idea_category'), url: '/idea_categories', active: true, icon: 'fe-file-text' },
#                   { name: I18n.t('texts.idea.my_ideas'), url: '#', active: true, icon: 'fe-archive' },
#
#                   # administracao
#                   { name: I18n.t('texts.administration'), url: '#', active: true, icon: 'fe-box' },
#                   { name: I18n.t('activerecord.models.menus'), url: '/menus', active: true, icon: '', ancestry: 7 },
#                   { name: I18n.t('activerecord.models.profiles'), url: '/profiles', active: true, icon: '', ancestry: 7 },
#                   { name: I18n.t('activerecord.models.users'), url: '/users', active: true, icon: '', ancestry: 7 }
#                 ])
#
#     Profile.destroy_all
#     ActiveRecord::Base.connection.reset_pk_sequence!('profiles')
#     Profile.create([
#                      { name: 'Administrador',
#                        description: 'Administrador do sistema',
#                        active: true,
#                        namespace: 'admin',
#                        permissions: {"AcademicWorksController":{"create":"true","destroy":"true","edit":"true","index":"true","new":"true","show":"true","update":"true"},"CoursesController":{"create":"true","destroy":"true","edit":"true","index":"true","new":"true","show":"true","toggle_status":"true","update":"true"},"IdeasController":{"create":"true","destroy":"true","edit":"true","index":"true","my_ideas":"true","new":"true","show":"true","update":"true"},"IdeaCategoriesController":{"create":"true","destroy":"true","edit":"true","index":"true","new":"true","show":"true","update":"true"},"TeachersController":{"create":"true","destroy":"true","edit":"true","index":"true","new":"true","show":"true","toggle_status":"true","update":"true"},"MenusController":{"create":"true","destroy":"true","edit":"true","index":"true","new":"true","show":"true","update":"true"},"ProfilesController":{"create":"true","destroy":"true","edit":"true","index":"true","new":"true","show":"true","update":"true"},"UsersController":{"alterar_perfil":"true","create":"true","destroy":"true","edit":"true","index":"true","new":"true","show":"true","update":"true"}} },
#                      { name: 'Arquivador',
#                        description: 'Gerencia os trabalhos acadêmicos',
#                        active: true,
#                        namespace: 'archiver',
#                        permissions: {"AcademicWorksController":{"create":"true","destroy":"true","edit":"true","index":"true","new":"true","show":"true","update":"true"}} },
#                      { name: 'Idealizador',
#                        description: 'Compartilha ideias',
#                        active: true,
#                        namespace: 'ideializer',
#                        permissions: {"IdeasController":{"create":"true","destroy":"true","edit":"true","index":"true","my_ideas":"true","new":"true","show":"true","update":"true"},"UsersController":{"alterar_perfil":"true","destroy":"true","edit":"true","show":"true","update":"true"}} },
#                      { name: 'Colaborador',
#                        description: 'Colabora com o desenvolvimento de ideias',
#                        active: true,
#                        namespace: 'collaborator',
#                        permissions: {"IdeasController":{"create":"true","destroy":"true","edit":"true","index":"true","my_ideas":"true","new":"true","show":"true","update":"true"}} },
#                    ])
#
#     ProfileMenu.destroy_all
#     ActiveRecord::Base.connection.reset_pk_sequence!('profile_menus')
#     ProfileMenu.create(
#       [
#         { menu_id: 1, profile_id: 1 },
#         { menu_id: 2, profile_id: 1 },
#         { menu_id: 3, profile_id: 1 },
#         { menu_id: 4, profile_id: 1 },
#         { menu_id: 5, profile_id: 1 },
#         { menu_id: 6, profile_id: 1 },
#         { menu_id: 7, profile_id: 1 },
#         { menu_id: 8, profile_id: 1 },
#         { menu_id: 9, profile_id: 1 },
#         { menu_id: 10, profile_id: 1 },
#       ]
#     )
#
#     # ProfileUser.destroy_all
#     # ActiveRecord::Base.connection.reset_pk_sequence!('profile_users')
#     # ProfileUser.create({ profile_id: 1, user_id: User.first.id })
#
#     puts "success"
#   rescue => error
#     puts "error ==> #{error}"
#     raise ActiveRecord::Rollback
#   end
# end

# # #inicia transacao
# ActiveRecord::Base.transaction do
#   begin
#     users_params = []
#
#     (1..10).each do |i|
#       profile = Profile.where(namespace: :collaborator).first
#       users_params << {
#         email: "email#{i}@gmail.com",
#         name: "user_#{i}",
#         password: 'kleber',
#         profile_ids: [profile.id]
#       }
#     end
#
#
#     users_params.each do |user_params|
#       user = User.new(user_params)
#       user.save!
#     end
#
#     puts "success"
#   rescue => error
#     puts "error ==> #{error}"
#     raise ActiveRecord::Rollback
#   end
# end

# #inicia transacao
ActiveRecord::Base.transaction do
  begin
    ideas_params = []

    (1..10).each do |i|
      ideas_params << {
        title: "(#{i}) Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
        status: :public,
        possibility_reward: true,
        possibility_business: false,
        ideializer_id: 4,
        problem_to_solve: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        suffering_people: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        proposed_solution: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        differential: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        idea_category_id: IdeaCategory.all.sample.id,
        locality: "Porto Nacional, TO"
      }
    end

    ideas_params.each do |idea_params|
      idea = Idea.new(idea_params)
      idea.save!
    end

    puts "success"
  rescue => error
    puts "error ==> #{error}"
    raise ActiveRecord::Rollback
  end
end