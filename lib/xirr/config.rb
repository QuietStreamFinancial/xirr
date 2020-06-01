module Xirr
  include ActiveSupport::Configurable

  # Sets as constants all the entries in the Hash Default values
  default_values = {
      eps:             '1.0e-6'.to_f,
      period:          365.0,
      iteration_limit: 50,
      precision:       6,
      default_method:  :newton_method,
      fallback:        true,
      replace_for_nil: 0.0,
      compact: true,
      raise_exception: false
  }

  # Iterates though default values and sets in config
  default_values.each do |key, value|
    self.config.send("#{key.to_sym}=", value)
  end

  # Allow config values to be accessed via module "constants"
  # e.g. Xirr::REPLACE_FOR_NIL instead of Xirr.config.replace_for_nil
  def self.const_missing(symbol)
    config_key = symbol.to_s.downcase.to_sym

    super unless self.config.has_key?(config_key)

    self.config[config_key]
  end
end
