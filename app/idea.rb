# frozen_string_literal: true

require 'yaml/store'

# The class that models the main data type
class Idea
  attr_reader :title, :description

  # Section one - CRUD

  def initialize(attributes)
    @title = attributes[:title] || attributes['title']
    @description = attributes[:description] || attributes['description']
  end

  def self.all
    raw_ideas.map do |data|
      Idea.new(data)
    end
  end

  def self.find(position)
    Idea.new(find_raw_idea(position))
  end

  def self.update(position, data)
    database.transaction do
      database['ideas'][position.to_i] =
        { title: data[:title] || data['title'], description: data[:description] || data['description'] }
    end
  end

  def self.delete(position)
    database.transaction do
      database['ideas'].delete_at(position)
    end
  end

  # Section Two - Internals
  ## Retrieving raw data
  def self.raw_ideas
    database.transaction do |db|
      db['ideas'] || []
    end
  end

  def self.find_raw_idea(position)
    database.transaction do
      database['ideas'].at(position)
    end
  end
end
