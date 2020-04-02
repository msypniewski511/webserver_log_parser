# frozen_string_literal: true

# Reading and storing data
class WebserverLogParser
  def initialize(file)
    @file = file
  end

  def call
    puts file.read
  end

  private

  attr_reader :file
end
