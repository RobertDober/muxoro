
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


  spec.required_rubygems_version = '>= 2.2.2'

  spec.add_dependency 'daemons', '~> 1.2'
#  spec.add_dependency 'lab42_core', '~> 0.3'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rspec', '~> 3.3'
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'pry-nav', '~> 0.2'
  spec.add_development_dependency 'timecop', '~> 0.8'
end
