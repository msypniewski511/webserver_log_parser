# frozen_string_literal: true

require_relative 'visit'
require_relative 'fetch_and_print_data'

# Reading a file and storing data
class ParseAndStoreData
  def initialize(file)
    @file = file
    @invalid_entries = []
  end

  def call
    file.each_line do |line|
      # split on whitespace is the default
      parse_and_store_data(line.split)
    end

    FetchAndPrintData.new(model_klass, invalid_entries).call
  end

  private

  attr_reader :file
  attr_accessor :invalid_entries

  def parse_and_store_data(arr)
    visit = model_klass.new(model_klass::ATTRS.zip(arr))
    visit.valid? ? visit.save : log_invalid_entry(arr, visit)
  end

  def log_invalid_entry(arr, visit)
    invalid_entries << visit.errors.full_messages.concat(arr)
  end

  def model_klass
    Visit
  end
end
