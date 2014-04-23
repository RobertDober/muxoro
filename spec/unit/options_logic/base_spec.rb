require 'spec_helper'

require 'muxoro/options_logic'

describe Muxoro::OptionsLogic do 
  context 'simple value logic' do 
    subject do
      described_class.new( { 
        lhs: 1,
        rhs: 2,
        sum: ->{ get( :lhs ) + get( :rhs ) },
        prod: ->{ get( :sum ) * get( :rhs ) }
      } )
    end

    context 'with all defaults' do 
      before do
        subject.set_values {}
      end
      it {
        expect( subject.get( :lhs ) ).to eq( 1 )
      }
      it {
        expect( subject.get( :sum ) ).to eq( 3 )
      }
      it {
        expect( subject.get( :prod ) ).to eq( 6 )
      }
    end # context 'with all defaults'

    context 'with some values' do 
      before do
        subject.set_values rhs: 41, product: 0
      end
      it 'lhs is still default' do
        expect( subject.get( :lhs ) ).to eq( 1 )
      end 
      it 'but rhs is not' do
        expect( subject.get( :rhs ) ).to eq( 41 )
      end
      it 'influences the computations too' do
        expect( subject.get( :sum ) ).to eq( 42 )
        expect( subject.get( :product ) ).to eq( 0 )
      end
    end # context 'with some values'

  end # context 'simple value logic'
end # describe Muxoro::OptionsLogic
