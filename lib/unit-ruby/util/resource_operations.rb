require 'active_support/core_ext/enumerable'

module Unit
  module ResourceOperations
    module Find
      def self.included(klass)
        klass.extend(ClassMethods)
      end

      module ClassMethods
        # @param where [Hash] Optional. Filters to apply.
        def find(id, where: nil, options: {})
          headers = options.fetch(:headers, {})
          params = { filter: where }.compact
          located_resource = connection.get(resource_path(id), params, headers)

          build_resource_from_json_api(located_resource)
        end
      end
    end

    module FindByAccount
      def self.included(klass)
        klass.extend(ClassMethods)
      end

      module ClassMethods
        def find_by_account(account_id:, id:, options: {})
          headers = options.fetch(:headers, {})
          located_resource = connection.get("/accounts/#{account_id}#{resource_path(id)}", nil, headers)

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
          options = attributes.fetch(:options, {})
          headers = options.fetch(:headers, {})
          
          resource = new(attributes.without(:id, :options))

          data = {
            type: resource.resource_type,
            attributes: resource.as_json_api.slice(*resource.dirty_attributes)
          }
          unless resource.relationships.empty?
            data[:relationships] =
              resource.relationships
          end

          created_resource = connection.post(resources_path(id), { data: data }, headers)

          build_resource_from_json_api(created_resource)
        end
      end
    end

    module BulkCreate
      def self.included(klass)
        klass.extend(ClassMethods)
      end

      module ClassMethods
        def bulk_create(attributes_list, options: {})
          headers = options.fetch(:headers, {})
          data_list = attributes_list.map do |attributes|
            resource = new(attributes.without(:id))

            data = {
              type: resource.resource_type,
              attributes: resource.as_json_api.slice(*resource.dirty_attributes)
            }
            unless resource.relationships.empty?
              data[:relationships] =
                resource.relationships
            end
            data
          end

          created_resource_list = connection.post(resources_path, { data: data_list }, headers)

          created_resource_list.map do |created_resource|
            build_resource_from_json_api(created_resource)
          end
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
        def list(where: {}, limit: 100, offset: 0, sort: nil, options: {})
          headers = options.fetch(:headers, {})
          params = { filter: where, page: { offset: offset, limit: limit },
                     sort: sort }.compact
          resources = connection.get(resources_path, params, headers)

          resources.map { |resource| build_resource_from_json_api(resource) }
        end
      end
    end

    module Save
      def save(options: {})
        headers = options.fetch(:headers, {})
        updated_resource = self.class.connection.patch(
          resource_path,
          {
            data: {
              type: resource_type,
              attributes: as_json_api.slice(*dirty_attributes)
            }
          },
          headers
        )

        update_resource_from_json_api(updated_resource)
      end
    end
  end
end
