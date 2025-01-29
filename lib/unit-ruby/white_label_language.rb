module Unit
  class WhiteLabelLanguage < APIResource
    path '/white-label/language'

    include ResourceOperations::List
    include ResourceOperations::Find
    include ResourceOperations::Replace
  end
end
