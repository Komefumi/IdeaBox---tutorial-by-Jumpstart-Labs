# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('lib', __dir__)

require 'rubygems'
require 'bundler'

Bundler.require

require 'app'
run IdeaBoxApp
