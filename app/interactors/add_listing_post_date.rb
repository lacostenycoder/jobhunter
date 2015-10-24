class AddListingPostDate
  include Interactor
  require 'open-uri'

  def call
    if context.url = context.url
      begin
        doc = Nokogiri::HTML(open(context.url))
        date = doc.css('#display-date').text
        date = date.split(':')[1].strip.split.first.to_date
        context.date = date
      rescue OpenURI::HTTPError => ex
        doc =  404
      context.fail!(message: doc)
      end
    else
      context.fail!(message: "ex")
    end
  end

end
