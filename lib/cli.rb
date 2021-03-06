# frozen_string_literal: true

require_relative 'parse_and_store_data'

# Entrypoint for arguments parsing and logic executing
class Cli
  def initialize(argv = [])
    @argv = argv
  end

  def call
    if argv.empty?
      puts 'Please provide a file location to get the webserver log report.'
    else
      ParseAndStoreData.new(file).call
    end
  rescue Errno::ENOENT
    puts "Could not open the file #{argv[0]}. Please verify the file location."
  end

  private

  attr_reader :argv

  def file
    File.open(argv[0], 'r')
  end
end
