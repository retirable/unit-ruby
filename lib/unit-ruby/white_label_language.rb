module Unit
  class WhiteLabelLanguage < APIResource
    path '/white-label/language'

    def save_config(config_json)
      updated_resource = self.class.connection.put_json(
        self.class.resource_path(id),
        {
          data: {
            type: resource_type,
            attributes: config_json
          }
        }
      )
      update_resource_from_json_api(updated_resource)
    end

    include ResourceOperations::List
    include ResourceOperations::Find
  end
end
