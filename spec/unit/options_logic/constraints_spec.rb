require 'spec_helper'

require 'muxoro/options_logic'

def expect_value_of key
  expect( subject.get key )
end

describe Muxoro::OptionsLogic, :wip do 

  context 'constraints' do
    subject do
      described_class.new( { 
        periods: ->{ get( :duration, 20 ) / get( :period, 5 ) },
        period: ->{ get( :duration, 20 ) / get( :periods ) },
        duration: ->{ get( :periods ) * get( :period ) }
      } ).set_constraints do |c|
        c.and( :period, :duration, :periods ) do 
          raise ArgumentError, 'xxx'
        end
      end
    end

    context 'no constraint violation' do 
      it 'for periods and duration' do
        subject.set_values periods: 1, duration: 10
        expect_value_of( :period ).to eq( 10 )
      end
      it 'for period and periods' do
        subject.set_values periods: 2, period: 5
        expect_value_of( :duration ).to eq( 10 )
      end
      it 'for period and duration' do
        subject.set_values period: 2, duration: 10
        expect_value_of( :periods ).to eq( 5 )
      end
    end # context 'with all defaults'

    it 'constraint violation' do 
      expect( ->{ 
        subject.set_values period: 1, duration: 1, periods: 1
      } ).to raise_error( ArgumentError, 'xxx' )
    end # context 'constraint violation'
  end # context 'constraints'


end # describe Muxoro::OptionsLogic
