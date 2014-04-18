require 'aruba/cucumber'
require 'rspec/expectations'
require 'rspec/mocks'

module Receive
  def receive a, &b
    RSpec::Matchers::Receive.new a, b
  end
end # module Receive
World( RSpec::Matchers )
World( RSpec::Expectations::Syntax )
World( Receive )
# World( RSpec::Mocks::Syntax )
