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

  class << self
    def group_by_path_with_count
      group_and_count(:path).order { count.desc }.all
    end

    def unique_visits
      query = <<-SQL
        SELECT `path`, count(DISTINCT `visitor_identifier`) AS `count`
        FROM `visits`
        GROUP BY 1
        ORDER BY `count` DESC
      SQL

      fetch(query).all
    end
  end
end
