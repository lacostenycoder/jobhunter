Given /^my rails app basic functionallity works$/ do
  puts "start the test"
end

When /^I visit the homepage$/ do
  visit root_path
end


Then /^I should see relavant job listings$/ do
  page.should have_content('Ruby')
end
