require 'spec_helper'
require 'muxoro/cli'

describe Muxoro::CLI do 
  
  context 'No system interaction for help' do 
    before do
      expect( subject ).not_to receive( :` )
    end
    it{ subject.run %w{ :help } }
  end # context 'No system interaction for help'

end # describe Muxoro::CLI
