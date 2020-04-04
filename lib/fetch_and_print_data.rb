# frozen_string_literal: true

# Fetching and printing data
class FetchAndPrintData
  def initialize(model_klass, invalid_entries)
    @model_klass = model_klass
    @invalid_entries = invalid_entries
  end

  def call
    print_data(model_klass.group_by_path_with_count, &print_valid)
    print_data(model_klass.unique_visits, &print_valid)
    print_data(invalid_entries, &print_invalid)
  end

  private

  attr_reader :model_klass, :invalid_entries

  def print_valid
    proc { |entry| puts "#{entry[:path]} #{entry[:count]}" }
  end

  def print_invalid
    proc { |entry| puts "Error: '#{entry[0]}' in line: '#{entry[1]}'" }
  end

  def print_data(query, &block)
    return if query.count.zero?

    query.each(&block)
    puts
  end
end
