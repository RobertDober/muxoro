module Muxoro
  class OptionsLogic
    module Constraints

      def check_constraints!
        @constraints.each do | constraint |
          constraint.arity == 1 ? instance_eval( &constraint ) : instance_exec( &constraint ) 
        end
      end

      def and *conds, &blk
        conds.each{ |e|
          return false unless __bool e
        }
        blk.() if blk
        true
      end

      def not cond, &blk
        return false if __bool cond
        blk.() if blk
        true
      end
      
      private
      def __bool e
        Symbol === e ? @values.fetch( e, false ) : e
      end
    end # module Constraints
  end # class OptionsLogic
end # module Muxoro
