module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :checks

    def validate(type, arg, option = nil)
      @checks ||= []
      @checks.push(type: type, arg: arg, option: option)
    end
  end

  module InstanceMethods
    def validate!
      self.class.checks.each { |validate| self.send "validate_#{validate[:type].to_sym}", instance_variable_get("@#{validate[:arg]}".to_sym), validate[:option] }
    end

    def valid?
      validate!
      true
    rescue
      false
    end

    private

    def presence(value, _options)
      raise 'Значение не может быть пустым' if value.empty?
    end

    def format(value, options)
      raise 'Неверный формат' if value !~ options
    end

    def type(value, options)
      raise 'Несоответствие класса' if value.class == options
    end
  end
end
