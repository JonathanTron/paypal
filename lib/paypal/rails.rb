require 'active_support'
require File.join(File.dirname(__FILE__),'helpers', '/common')
require File.join(File.dirname(__FILE__),'helpers', '/rails')

ActionView::Base.send(:include, Paypal::Helpers::Common)
ActionView::Base.send(:include, Paypal::Helpers::Rails)