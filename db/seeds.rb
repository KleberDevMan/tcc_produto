#inicia transacao
ActiveRecord::Base.transaction do
  begin

    Menu.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('menus')
    Menu.create([
                  # Mural de ideias
                  { name: I18n.t('texts.idea.wall_of_ideas'), url: '/ideas', active: true, icon: 'fe-home' },

                  # Mural de trabalhos
                  { name: I18n.t('activerecord.models.teachers'), url: '/teachers', active: true, icon: 'fe-users' },
                  { name: I18n.t('activerecord.models.courses'), url: '/courses', active: true, icon: 'fe-tv' },
                  { name: I18n.t('activerecord.models.academic_works'), url: '/academic_works', active: true, icon: 'fe-file-text' },

                  # Depósito de ideias
                  { name: I18n.t('activerecord.models.idea_category'), url: '/idea_categories', active: true, icon: 'fe-file-text' },
                  { name: I18n.t('texts.idea.my_ideas'), url: '#', active: true, icon: 'fe-archive' },

                  # administracao
                  { name: I18n.t('texts.administration'), url: '#', active: true, icon: 'fe-box' },
                  { name: I18n.t('activerecord.models.menus'), url: '/menus', active: true, icon: '', ancestry: 7 },
                  { name: I18n.t('activerecord.models.profiles'), url: '/profiles', active: true, icon: '', ancestry: 7 },
                  { name: I18n.t('activerecord.models.users'), url: '/users', active: true, icon: '', ancestry: 7 }
                ])

    Profile.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('profiles')
    Profile.create([
                     { name: 'Administrador',
                       description: 'Administrador do sistema',
                       active: true,
                       namespace: 'admin',
                       permissions: {} },
                     { name: 'Arquivador',
                       description: 'Gerencia os trabalhos acadêmicos',
                       active: true,
                       namespace: 'archiver',
                       permissions: {} },
                     { name: 'Idealizador',
                       description: 'Compartilha ideias',
                       active: true,
                       namespace: 'ideializer',
                       permissions: {} },
                     { name: 'Colaborador',
                       description: 'Colabora com o desenvolvimento de ideias',
                       active: true,
                       namespace: 'collaborator',
                       permissions: {} },
                   ])

    ProfileMenu.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('profile_menus')
    ProfileMenu.create(
      [
        { menu_id: 1, profile_id: 1 },
        { menu_id: 2, profile_id: 1 },
        { menu_id: 3, profile_id: 1 },
        { menu_id: 4, profile_id: 1 },
        { menu_id: 5, profile_id: 1 },
        { menu_id: 6, profile_id: 1 },
        { menu_id: 7, profile_id: 1 },
        { menu_id: 8, profile_id: 1 },
        { menu_id: 9, profile_id: 1 },
        { menu_id: 10, profile_id: 1 },
      ]
    )

    ProfileUser.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('profile_users')
    ProfileUser.create({ profile_id: 1, user_id: User.first.id })

    puts "success"
  rescue => error
    puts "error ==> #{error}"
    raise ActiveRecord::Rollback
  end
end