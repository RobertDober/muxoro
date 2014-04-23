require 'lab42/options'

module Muxoro
  class CLI

    attr_reader :options

    def init args
      @sleepy  = 60
      @minutes = 25
      parser   = Lab42::Options.new
      @options = parser.parse( args )
      self
    end

    def reset_sessions
      @open_sessions.each do |s|
        system %{tmux set-option -qt #{s} status-left "Session: #{session_name s}"}
      end
    end

    def run args
      init args

      if options.help
        puts 'muxoro [options]'
        return
      end
      run!
    end

    def run!
      get_open_sessions
      run_sessions
      end_sessions
    end

    private
    def compute_current_session_name
      session_number = ENV['TMUX'].split(',').last
      session_list   = %x{tmux info}.split(/\n/)
      index = session_list.find_index{ |line| /\ASessions:/ === line }
      session_list = session_list.drop index.succ
      current_session = session_list.find{ |line| /\A #{session_number}:/ === line }
      current_session_name = current_session.split[1].sub(/:\z/,'')
    end

    def current_session_name
      @__current_session_name__ ||=
        compute_current_session_name
    end

    def end_sessions
      @open_sessions.each do |s|
        system %{tmux set-option -qt #{s} status-left "#[fg=black,bg=red]Session: #{session_name s}|**"}
      end
      sleep @sleepy
      reset_sessions
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
          system %{tmux set-option -qt #{s} status-left "Session: #{session_name s}|#{m}"}
        end
        sleep @sleepy
      }
    end

    def session_name s
      return s unless s == ":"
      current_session_name
    end
  end # module CLI
end # module Muxoro
