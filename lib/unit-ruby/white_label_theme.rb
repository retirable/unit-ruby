module Unit
  class WhiteLabelTheme < APIResource
    path '/white-label/theme'

    include ResourceOperations::List
    include ResourceOperations::Find
    include ResourceOperations::Replace
  end
end
