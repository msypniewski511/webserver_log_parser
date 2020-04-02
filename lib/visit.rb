# frozen_string_literal: true

require_relative '../db_connection'

# Model to store log entities in the memory database
class Visit < Sequel::Model
  plugin :validation_helpers

  ATTRS = %i[path visitor_identifier].freeze

  def validate
    super

    validates_presence ATTRS
  end
end
