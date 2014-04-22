require 'spec_helper'
require 'muxoro/cli'

describe Muxoro::CLI do

  context 'system interaction with time parameters in the current session' do 
    ENV['TMUX'] = 'Some value'

    before do
      expect( subject ).to_not receive( :` )
        .with( 'tmux ls' )

      expect_sleeps seconds: 20, times: 61
      expect_tmux_commands with_values: %w{20'} +
        19.downto(1).to_a.product( [ '40"', '20"', ''] ).map(&:join)
    end

    it{ subject.run %w{ time: 20 interval: 20s } }

  end # context 'system interaction with default usage and two tmux sessions'
    
end # describe Muxoro::CLI

