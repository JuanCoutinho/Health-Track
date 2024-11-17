# app/services/concerns/service_base.rb
class ServiceBase
  def self.call(*args, **kwargs)
    new(*args, **kwargs).call
  end

  def call
    raise NotImplementedError, "#{self.class}#call must be implemented"
  end
end
