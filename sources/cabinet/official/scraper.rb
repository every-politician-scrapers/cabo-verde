#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    field :name do
      Name.new(
        full: noko.css('strong,b').map(&:text).join(' ').tidy,
        prefixes: %w[Dr.. Dr. Doutor Eng.],
      ).short
    end

    field :position do
      noko.css('h3').first.text.split(/(?:,| e) (?=Ministr[ao])/).map(&:tidy)
    end
  end

  class Members
    def member_container
      noko.css('.grid')
    end
  end
end

dir = Pathname.new 'mirror/'
puts EveryPoliticianScraper::FileData.new(dir.children).csv
