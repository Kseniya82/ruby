module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(name, type, *args)
      @validations ||= []
      @validations << { name_var: name, type: type, args: args }
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    protected

    def validate!
      self.class.validations.each do |validation|
        args = [validation[:name_var]]
        args << validation[:args] if validation[:args] != []
        send("validate_#{validation[:type]}", *args)
      end
    end

    def validate_presence(name)
      raise "Атрибут #{name} не задан" if name.nil? || name == ''
    end

    def validate_format(name, format)
      raise "Атрибут #{name} не соответствует формату #{format}" if send(name) !~ format.first
    end

    def validate_type(name, type)
      raise "Атрибут #{name} не соответствует типу #{type.first}" if send(name).class != type.first
    end
  end
end
