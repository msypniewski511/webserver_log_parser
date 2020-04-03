# frozen_string_literal: true

require_relative 'visit'

# Reading a file and storing data
class WebserverLogParser
  def initialize(file)
    @file = file
    @invalid_entries = []
  end

  def call
    file.each_line do |line|
      # split on whitespace is the default
      parse_and_store_data(line.split)
    end

    # temporarly prints Visit collection from here
    Visit.each { |visit| puts "#{visit.path}, #{visit.visitor_identifier}" }
  end

  private

  attr_reader :file
  attr_accessor :invalid_entries

  def parse_and_store_data(arr)
    visit = Visit.new(Visit::ATTRS.zip(arr))
    visit.valid? ? visit.save : log_invalid_entry(arr, visit)
  end

  def log_invalid_entry(arr, visit)
    invalid_entries << arr.push(visit.errors.full_messages)
  end
end
