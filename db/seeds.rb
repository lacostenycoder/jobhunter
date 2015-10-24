# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

words = ["backend developer",
 "frontend developer",
 "html css",
 "javascript",
 "junior developer",
 "junior software",
 "php",
 "ruby",
 "ruby on rails",
 "software engineer",
 "web designer",
 "web developer"]

words.each{ |w| Keyword.create(word: w) }

# uncomment this section to filter out unwanted keywords to start.
hide_words = [
  "Bad Rabbit",
  "Bookkeeper",
  "Salesforce Administrator",
  "accountant",
  "analyst",
  "architect",
  "assistant",
  "associate",
  "blogger",
  "boiler",
  "buyer",
  "buyers",
  "cabinet",
  "caregiver",
  "catering",
  "cook",
  "cooks",
  "coordinator",
  "delivery",
  "donors",
  "driver",
  "examiner",
  "executive",
  "facilitator",
  "fashion",
  "jewelry",
  "lingerie",
  "manager",
  "managerager",
  "marketing",
  "mechanic",
  "operations",
  "plumbing",
  "president",
  "recruiting",
  "sales",
  "survey",
  "tuesday",
  "tuesdays"
]

hide_words.each do |hide_word|
  Keyword.create({word:hide_word, hide: true})
end

# special css filters on add matching pattern to hide ads
# used to create heavy CL duplicate add posters

listing_filters = [
  { css_selector: "a", text: "varsitytutors" },
  { css_selector: "img", text: "varsitytutors"}
]

listing_filters.each{|lf| ListingFilter.create(lf)}
