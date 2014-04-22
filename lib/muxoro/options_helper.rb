module Muxoro
  class OptionsHelper
    Defaults = { 
      time: 25,
      interval: 1,
      intervals: 21
    }

    Defaults.keys.each do | key |
      define_method key do
        __fetch key
      end
      define_method "#{key}?" do
        @options.to_h.has_key? key
      end
    end

    private
    def initialize options=OpenStruct.new
      @options = options
    end

    def __fetch key
      @options.to_h.fetch key, Defaults.fetch( key )
    end
  end # class OptionsHelper
end
