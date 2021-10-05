require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)

Given /^the following movies exist:$/ do |movies_table|
  movies_table.hashes do |movie|
    Movie.create!(movie)
  end
end

Given /^I check the following ratings: (.*)$/ do |field|
  field.split(%r{,\s*}).each do |rating|
    check("ratings_#{rating}")
  end
end

Given /^I uncheck the following ratings: (.*)$/ do |field|
  field.split(%r{,\s*}).each do |rating| 
    uncheck("ratings_#{rating}")
  end
end

Then /^(?:|I )should see all of the movies$/ do
  # Make sure that all the movies in the app are visible in the table
  #flunk "Unimplemented"
  #assert page.all('#movies tr').size - 1 == Movie.count()
  rows = page.all('#movies tr').size - 1 
  assert rows == Movie.count()
end

Given(/^I check all ratings$/) do
  Movie.all_ratings.each do |rating|
    check("ratings[#{rating}]")
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  assert page.body.index(e1) < page.body.index(e2)
  #flunk "Unimplemented"
end