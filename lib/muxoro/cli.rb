# require 'logger'
require 'lab42/core'
require_relative 'tmux'
module Muxoro
  class CLI

    attr_reader :help_asked, :time, :sleep_interval, :short_sleep_interval, :orange_zone, :red_zone, :red_bg, :orange_bg, :red_fg,:orange_fg

    attr_reader :tmux

    def help
      return nil unless help_asked
      $stderr.puts help_text
      true
    end

    def init args
      @help_asked           = args.include? ":help"
      @time                 = get_int_from( args, 'time:', 25 ) * 60
      @sleep_interval       = get_int_from args, 'sleep_interval:', 60
      @short_sleep_interval = get_int_from args, 'short_sleep_interval:', 10
      @orange_zone          = get_int_from args, 'orange_zone:', 300
      @red_zone             = get_int_from args, 'red_zone:',60
      @red_bg               = get_str_from args, 'red_bg:', 'red'
      @orange_bg            = get_str_from args, 'orange_bg:', '#882288'
      @red_fg               = get_str_from args, 'red_fg:', 'black'
      @orange_fg            = get_str_from args, 'orange_fg:', 'green'

      # @logger = Logger.new File.expand_local_path{ %W{ .. .. log #{self.class.name.split("::").last}.log} }
      # log "#{inspect} initialized"
      self
    end

    def reset
      tmux.set_left_status fg: 'cyan', time: '', bg: '#222222'
    end

    def run! session_name
      # log ">>>run!"
      @tmux = Tmux.new session_name # , @logger
      # log  "tmux created"
      loop do
        set_current_status
        break if finished?
        wait_tick
      end
      reset
    end

    private
    def current_background
      if red_zone?
        red_bg
      elsif orange_zone?
        orange_bg
      else
        '#333333'
      end
    end
    def current_foreground
      if red_zone?
        red_fg
      elsif orange_zone?
        orange_fg
      else
        'cyan'
      end
    end
    def current_time
      time <= 60 ? "#{time}s" : "#{time/60}m"
    end

    def finished?
      time < 0
    end
    def get_int_from args, val, default
      get_from( args, val, default ).to_i
    end
    def get_str_from args, val, default
      get_from( args, val, default ).to_s
    end
    def get_from args, val, default
      rgx  = %r{\A#{val}}
      args = args.grep rgx
      return default if args.empty?
      args.first.sub rgx, ''
    end

    def help_text
      <<-EOS

args are #{inspect}

-----------------------------------------------------------------------------------

muxoro [params]
   stop   stops the current muxoro timer and resets the session's display
   :help  shows this message and exits

   All other parameters start a new muxoro timer daemon with the following behavior

   time:                  in minutes defaults to 25
   sleep_interval:        updates in seconds defaults to 60
   short_sleep_interval:  updates in seconds in the red_zone defaults to 10
   orange_zone:           orange display of timer
   red_zone:              time left in seconds in which timer is displayed in red
   oraneg_bg:             defaults to '#ffdd22'
   red_bg:                defaults to 'red'
      EOS
    end

    def log msg
      @logger.info msg if @logger
    end
    def orange_zone?
      time <= orange_zone
    end
    def red_zone?
      time <= red_zone
    end
    def set_current_status
      # log ">>>#{__method__} bg: #{current_background}"
      tmux.set_left_status bg: current_background, time: "[#{current_time}]", fg: current_foreground
    end

    def wait_tick
      sleep_time = red_zone? ? short_sleep_interval : sleep_interval
      @time -= sleep_time
      sleep sleep_time
    end
  end # class CLI
end # module Muxoro
