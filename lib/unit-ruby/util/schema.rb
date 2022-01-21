module Unit
  module Util
    class Schema
      Attribute = Struct.new(:name, :type, :readonly)

      def initialize
        @attributes = []
      end

      def add(name, type, readonly: false)
        @attributes << Attribute.new(name, type, readonly)
      end
      attr_reader :attributes
    end
  end
end
