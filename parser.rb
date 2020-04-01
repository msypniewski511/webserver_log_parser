#!/usr/bin/env ruby
# frozen_string_literal: true

require 'bundler/setup'
Bundler.require(:default)

require_all 'lib'

WebserverLogParser.new(ARGV).call
