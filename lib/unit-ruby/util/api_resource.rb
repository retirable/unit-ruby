module Unit
  module Util
    class APIResource
      attr_accessor :id, :type, :raw_data

      def initialize(attributes = {})
        clear_attributes!
        mark_as_clean!

        attributes.each do |key, value|
          send("#{key}=", value)
        end
      end

      # Creates a base http connection to the API
      #
      def self.connection
        @connection ||= Connection.new
      end

      # Defines the schema for a resource's attributes
      #
      def self.schema
        @schema ||= Util::Schema.new
      end

      def schema
        self.class.schema
      end

      # Declares a new attribute by name and adds it to the schema
      #
      # @param name [Symbol] the name of the attribute
      # @param type [Class] the object type
      # @param readonly [Boolean] excludes the attribute from the request when creating a resource
      def self.attribute(name, type = nil, readonly: false)
        schema.add(name, type, readonly: readonly)

        attr_accessor name

        define_method("#{name}=") do |value|
          previous_value = send(name)
          new_value = type.cast(value)

          instance_variable_set("@#{name}", new_value)

          mark_attribute_as_dirty(name) if new_value != previous_value
          new_value
        end
      end

      def relationships
        @relationships ||= {}
      end

      attr_writer :relationships

      # Sets the base path for this resource
      #
      # Usage:
      #  class Customer < Unit::Resource
      #      path '/customers'
      #  end
      def self.path(route = nil)
        return @path if route.nil?

        @path = route
      end

      def self.resource_path(id)
        "#{path}/#{id}"
      end

      def self.resources_path
        path
      end

      # The JSON:API type for this resource
      def resource_type
        self.class.name.split('::').last.camelize(:lower)
      end

      def resource_path
        "#{self.class.path}/#{id}"
      end

      # Creates an association to a related resource
      # This will create a helper method to traverse into a resource's related resource(s)
      def self.belongs_to(resource_name, class_name: nil)
        class_name ||= resource_name.to_s.camelize

        define_method(resource_name) do
          relationship_id = relationships[resource_name][:data]&.fetch(:id)

          return nil unless relationship_id

          Kernel.const_get(class_name).find(relationship_id)
        end

        define_method("#{resource_name}=") do |resource|
          relationships[resource_name] = {
            data: { type: resource_name, id: resource.id }
          }
        end
      end

      # Hyrdates an instance of the resource from data returned from the API
      def self.build_resource_from_json_api(data_item)
        new.tap do |resource|
          resource.mark_as_clean!
          resource.update_resource_from_json_api(data_item)
        end
      end

      def update_resource_from_json_api(data)
        self.id = data[:id]
        self.type = data[:type]
        self.raw_data = data
        self.relationships = data[:relationships]

        clear_attributes!

        data[:attributes].each { |key, value| update_attribute(key, value) }

        mark_as_clean!
      end

      # Represents this resource's attributes
      #
      # @return [Hash] Representation of this resource's attributes as a hash
      def attributes
        self.class.schema.attributes.each_with_object({}) do |schema_attribute, h|
          h[schema_attribute.name] = send(schema_attribute.name)
        end
      end

      # Represents this resource for serialization (create/update)
      #
      # @return [Hash] Representation of this object as JSONAPI object
      def as_json_api
        self.class.schema.attributes.each_with_object({}) do |schema_attribute, h|
          next if schema_attribute.readonly

          val = send(schema_attribute.name)

          # serialize the value if it is a complex type
          val = val.as_json_api if val.respond_to? :as_json_api

          h[schema_attribute.name] = val
        end
      end

      def dirty?
        dirty_attributes.any?
      end

      def dirty_attributes
        @dirty_attributes ||= []
      end

      def mark_attribute_as_dirty(name)
        dirty_attributes << name
      end

      def mark_as_clean!
        @dirty_attributes = []
      end

      def clear_attributes!
        schema.attributes.each do |attribute|
          update_attribute(attribute.name, nil)
        end
      end

      def update_attribute(name, value)
        return unless schema.contains? name

        send("#{name}=", value)
      end
    end
  end
end
