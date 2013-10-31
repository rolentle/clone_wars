require "minitest"
require "minitest/autorun"
require "minitest/pride"
require './lib/app'
ENV['RACK_ENV'] = 'test'

CloneWarsApp.configure do
  use RackSessionAccess::Middleware
end
