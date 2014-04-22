module TmuxCommandExpectations

  def expect_sleeps( seconds: required, times: required )
    expect( subject ).to receive( :sleep ).with( seconds ).exactly( times ).times
  end

  def expect_tmux_commands( for_sessions: %w{:}, with_values: values )

    # Countdown messages
    with_values.each do | value |
      for_sessions.each do | session |
        expect( subject ).to receive( :system )
        .with( %{tmux set-option -qt #{session} status-left "Session: #{session}|#{value}"} )
      end
    end


    # End and Clearing messages
    for_sessions.each do | session |
      expect( subject ).to receive( :system )
      .with( %{tmux set-option -qt #{session} status-left "#[fg=black,bg=red]Session: #{session}|**"} )
      expect( subject ).to receive( :system )
      .with( %{tmux set-option -qt #{session} status-left "Session: #{session}"} )
    end
  end

end # module TmuxCommandExpectations

RSpec.configure do | cfg |
  cfg.include TmuxCommandExpectations
end
