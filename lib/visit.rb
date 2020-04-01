# frozen_string_literal: true

require_relative '../db_connection'

# Model to store log entities in the memory database
class Visit < Sequel::Model
  plugin :validation_helpers

  def validate
    super

    validates_presence %i[path visitor_identifier]
  end
end
