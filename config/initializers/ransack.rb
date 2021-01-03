Ransack.configure do |config|
  config.add_predicate(
      # produces queries in the form of `WHERE (unaccent (column)) ILIKE unaccent (%foo%bar%)`
      'ucont',
      arel_predicate: 'ai_imatches', # <- thanks arel_extensions !
      formatter: proc { |s| ActiveSupport::Inflector.transliterate("%#{s.tr(' ', '%')}%") },
      validator: proc { |s| s.present? },
      compounds: true,
      type: :string
  )
end