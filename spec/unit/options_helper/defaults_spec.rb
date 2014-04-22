require 'spec_helper'

require 'muxoro/options_helper'

describe Muxoro::OptionsHelper do 
  
  context 'defaults' do 
    subject do
      described_class.new OpenStruct.new
    end

    it 'has a default time' do
      expect( subject.time ).to eq( 25 )
      expect( subject.time? ).to eq( false )
    end

    it 'has a default interval' do
      expect( subject.interval ).to eq( 1 )
      expect( subject.interval? ).to eq( false )
    end

    it 'has a default intervals' do
      expect( subject.intervals ).to eq( 1 )
      expect( subject.intervals? ).to eq( false )
    end
  end # context 'defaults'
end # descridobe Muxoro::OptionsHelper
