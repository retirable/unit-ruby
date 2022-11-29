module Unit
  class Schema
    Attribute = Struct.new(:name, :type, :readonly, :factory)

    def initialize
      @attributes = []
    end

    def contains?(name)
      attributes.map(&:name).include? name
    end

    def add(name, type, readonly: false, factory: nil)
      @attributes << Attribute.new(name, type, readonly, factory)
    end
    attr_reader :attributes
  end
end
