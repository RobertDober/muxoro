require 'spec_helper'
require 'muxoro/cli'

describe Muxoro::CLI do

  context 'system interaction with default usage and no tmux sessions' do 
    before do
      expect( subject )
        .to receive( :` )
        .with( 'tmux ls' )
        .and_return ''
    end

    it do
      expect( ->{ subject.run [] } ).to raise_error( RuntimeError, 'No tmux seessions running, aborting...' )
    end
    
  end # context 'system interaction with default usage'

  context 'system interaction with default usage and two tmux sessions' do 
    before do
      expect( subject ).to receive( :` )
        .with( 'tmux ls' )
        .ordered
        .and_return "0: \ncustom: regrgz?dfez(-ç_çfzefg"

      expect_sleeps seconds: 60, times: 26
      expect_tmux_commands for_sessions: %w{0 custom}, with_values: 25.downto(1)
    end
    it{ subject.run [] }
  end # context 'system interaction with default usage and two tmux sessions'
    
end # describe Muxoro::CLI

