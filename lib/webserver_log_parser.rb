# frozen_string_literal: true

# Entrypoint for arguments parsing and logic executing
class WebserverLogParser
  def initialize(args)
    @args = args
  end

  def call
    args
  end

  private

  attr_reader :args
end
