# frozen_string_literal: true

class Repository
  attr_reader :name, :star, :description, :url

  def initialize(name:, star:, description:, url:)
    @name = name
    @star = star
    @description = description
    @url = url
  end
end
