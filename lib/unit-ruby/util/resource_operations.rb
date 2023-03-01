module Unit
  module ResourceOperations
    module Find
      def self.included(klass)
        klass.extend(ClassMethods)
      end

      module ClassMethods
        def find(id)
          located_resource = connection.get(resource_path(id))

          build_resource_from_json_api(located_resource)
        end
      end
    end

    module Create
      def self.included(klass)
        klass.extend(ClassMethods)
      end

      module ClassMethods
        def create(attributes)
          id = attributes.fetch(:id, nil)
          resource = new(attributes.except(:id))

          data = {
            type: resource.resource_type,
            attributes: resource.as_json_api.slice(*resource.dirty_attributes)
          }
          unless resource.relationships.empty?
            data[:relationships] =
              resource.relationships
          end

          created_resource = connection.post(resources_path(id), { data: data })

          build_resource_from_json_api(created_resource)
        end
      end
    end

    module List
      def self.included(klass)
        klass.extend(ClassMethods)
      end

      module ClassMethods
        # List resources
        #
        # @param where [Hash] Optional. Filters to apply to the list.
        # @param limit	[Integer] Optional. Maximum number of resources that will be returned. Maximum is 1000 resources.
        # @param offset	[Integer] Optional. Number of resources to skip
        # @param sort [String] Optional. sort: 'createdAt' for ascending order or sort: '-createdAt' (leading minus sign) for descending order
        def list(where: {}, limit: 100, offset: 0, sort: nil)
          params = { filter: where, page: { offset: offset, limit: limit },
                     sort: sort }.compact
          resources = connection.get(resources_path, params)

          resources.map { |resource| build_resource_from_json_api(resource) }
        end
      end
    end

    module Save
      def save(attributes)
        resource = self.class.new(attributes.except(:id))
        updated_resource = self.class.connection.patch(
          self.class.resource_path(id),
          {
            data: {
              type: resource_type,
              attributes: resource.as_json_api.slice(*resource.dirty_attributes)
            }
          }
        )
        update_resource_from_json_api(updated_resource)
      end
    end
  end
end
