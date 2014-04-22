
module TmuxCommandExpectations
  def expect_commands m: 25, sessions: %w{:}, sleep: 60

    periods = m * 60 / sleep

    # periods time for the countdown + 1 for clearance of end message
    expect( subject ).to receive( :sleep ).with( sleep ).exactly( periods.succ ).times

    # Countdown messages
    periods.downto 1 do |m|
      sessions.each do | session |
        expect( subject ).to receive( :system )
          .with( %{tmux set-option -qt #{session} status-left "Session: #{session}|#{m}"} )
      end
    end

    sessions.each do | session |
      # End message
      expect( subject ).to receive( :system )
        .with( %{tmux set-option -qt #{session} status-left "#[fg=black,bg=red]Session: #{session}|**"} )
      # Clearance message
      expect( subject ).to receive( :system )
        .with( %{tmux set-option -qt #{session} status-left "Session: #{session}"} )
    end
  end
end # module TmuxCommandExpectations

RSpec.configure do | cfg |
  cfg.include TmuxCommandExpectations
end
