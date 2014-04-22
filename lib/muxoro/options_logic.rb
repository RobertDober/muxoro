require_relative 'options_logic/constraints'

module Muxoro
  class OptionsLogic

    include Constraints

    def set_constraints &blk
      raise ArgumentError, 'no block given' unless blk
      @constraints << blk
      self
    end
    # Can be called without values just to reset the cache
    def set_values values=nil
      invalidate_cache!
      return unless values
      raise ArgumentError, "values provided must be a hash" unless Hash === values
      @values = values
      check_constraints!
      self
    end

    def get key, *default
      return @cache[key] if @cache.has_key? key
      @cache[key] = compute( key, *default )
    end

    private
    def initialize lookup_logic={}
      @lookup = lookup_logic
      invalidate_cache!
      @values = {}
      @constraints = []
    end

    def compute key, *default
      return @values[key] if @values.has_key? key
      return default.first unless default.empty?
      # We are here because the cache is empty, and the key is not
      # defined in the values hash.
      # If there is no lookup logic we let the KeyError bubble up.
      default = @lookup.fetch key
      return default unless Proc === default
      instance_exec( &default )
    end

    def invalidate_cache!
      @cache  = {}
    end
  end # class OptionsLogic
end # module Muxoro
