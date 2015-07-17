Feature: Find Web Dev Jobs
  As a developer in need of work
  I want to find job leads
  So I can stop being a broke ass nigga!

Scenario: Display web dev job listings found on Craigslist
  Given my rails app basic functionallity works
  When I visit the homepage
  Then I should see relavant job listings
