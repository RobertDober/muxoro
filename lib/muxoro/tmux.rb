module Muxoro
  class Tmux

    attr_reader :current_session
    
    def set_left_status fg: nil, time: '', bg: 'grey'
      style = "bg=#{bg}"
      style = "fg=#{fg},#{style}" if fg
      tmux *%W{set-option -qt #{current_session} status-left-style #{style}}
      tmux *(%W{set-option -qt #{current_session} status-left} + ["Session: #{current_session} #{time}".strip.inspect])
    end

    private
    def initialize session_name, logger=nil
      @current_session = session_name.chomp
      @logger          = logger
      log "initialized"
    end

    def log *msg
      return unless @logger
      @logger.info "#{msg.join " "}"
    end

    def tmux *args
      log "tmux", *args
      system %{tmux #{args.join(' ')}}
    end

    
  end # class Tmux
end # module Muxoro
