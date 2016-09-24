require "csvid/version"
require 'csv'

module Csvid
  module ClassMethods
    def csv_path(path)
      @csv_path = path
    end

    def all
      results = []
      head, *body = CSV.read(@csv_path, encoding: "CP932")

      head.each_with_index do |field, index|
        define_method field do
          @line[index]
        end
      end

      body.each do |line|
        results << self.new(line)
      end

      results
    end
  end

  class << self
    def included(base)
      base.extend(ClassMethods)
    end
  end

  def initialize(line)
    @line = line
  end
end
