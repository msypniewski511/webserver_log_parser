#!/usr/bin/env ruby
# frozen_string_literal: true

require 'bundler/setup'
Bundler.require(:default)

require_all 'lib'

Cli.new(ARGV).call
