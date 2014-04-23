
base = File.dirname __FILE__
$:.unshift File.join( base, 'lib' )

require 'muxoro/version'

Gem::Specification.new do | spec |
  spec.name        = 'muxoro'
  spec.version     = Muxoro::VERSION
  spec.authors     = ['Robert Dober']
  spec.email       = %w{ robert.dober@gmail.com }
  spec.description = %{Launch a Pomodoro Timer from the command line}
  spec.summary     = %{Launch a Pomodoro Timer which updates the status line of all/given tmux sessions with a pomodoro timer}
  spec.homepage    = %{https://github.com/RobertDober/muxoro}
  spec.license     = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{\Abin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{\Atest|\Aspec|\Afeatures/})
  spec.require_paths = %w{lib}

  spec.post_install_message = %q{

  +============================================================================+
  |                                                                            |
  |  Attention: This is an alpha quality pre-release, NO WARRANTY WHATSOEVER   |
  |                                                                            |
  +============================================================================+

  Thanx for installing muxoro, launch your Pomodoro Timers from any command line
  on your machine, specify the tmux sessions to show the timers, configure color
  and intervals, have fun!

  For the impatient, a 25' timer that shows in all tmux sessions or the current
  session if launched inside a session, can be started via:
         muxoro

  Stop timer and reset status bar in all concerned sessions via:
         muxoro stop

  Any questions should be answered in the README https://github.com/RobertDober/muxoro
  If not, please open an issue.
  }


  spec.required_rubygems_version = '>= 2.2.2'

  spec.add_dependency 'lab42_options', '~> 0.4'
  spec.add_dependency 'daemons', '~> 1.1'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'cucumber', '~> 1.3'
  spec.add_development_dependency 'pry', '~> 0.9'
  spec.add_development_dependency 'pry-nav', '~> 0.2'
  spec.add_development_dependency 'timecop', '~> 0.7'
end
