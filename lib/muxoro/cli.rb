require 'lab42/options'

module Muxoro
  class CLI

    attr_reader :options

    def run args
      init args

      if options.help
        puts 'muxoro [options]'
        return
      end
      run!
    end

    private
    def init args
      @sleepy  = 60
      @minutes = 25
      parser   = Lab42::Options.new
      @options = OptionsHelper.new.init parser.parse( args )
    end

    def end_sessions
      @open_sessions.each do |s|
        system %{tmux set-option -qt #{s} status-left "#[fg=black,bg=red]Session: #{s}|**"}
      end
      sleep @sleepy
      @open_sessions.each do |s|
        system %{tmux set-option -qt #{s} status-left "Session: #{s}"}
      end
    end
    def get_open_sessions
      if @options.sessions
        @open_sessions = @options.sessions.split ','
      elsif ENV['TMUX']
        @open_sessions = %w{:}
      else
        @open_sessions =
          %x{tmux ls}
            .split("\n")
            .map{|l| l.sub /:.*/, '' }

        raise RuntimeError, 'No tmux seessions running, aborting...' if @open_sessions.empty?
        $stderr.puts 'Continuing...'
      end
    end

    def run_sessions
      @minutes.downto( 1 ){ |m|
        @open_sessions.each do |s|
          system %{tmux set-option -qt #{s} status-left "Session: #{s}|#{m}"}
        end
        sleep @sleepy
      }
    end
    def run!
      get_open_sessions
      run_sessions
      end_sessions
    end
  end # module CLI
end # module Muxoro
