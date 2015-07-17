class CraigsList
  #include Cities
  require 'nokogiri'
  require 'open-uri'
  require 'cgi'
  CITIES = ["auburn", "bham", "dothan", "shoals", "gadsden", "huntsville", "mobile", "montgomery", "tuscaloosa", "anchorage", "fairbanks", "kenai", "juneau", "flagstaff", "mohave", "phoenix", "prescott", "showlow", "sierravista", "tucson", "yuma", "fayar", "fortsmith", "jonesboro", "littlerock", "texarkana", "bakersfield", "chico", "fresno", "goldcountry", "hanford", "humboldt", "imperial", "inlandempire", "losangeles", "mendocino", "merced", "modesto", "monterey", "orangecounty", "palmsprings", "redding", "sacramento", "sandiego", "sfbay", "slo", "santabarbara", "santamaria", "siskiyou", "stockton", "susanville", "ventura", "visalia", "yubasutter", "boulder", "cosprings", "denver", "eastco", "fortcollins", "rockies", "pueblo", "westslope", "newlondon", "hartford", "newhaven", "nwct", "delaware", "washingtondc", "daytona", "keys", "fortlauderdale", "fortmyers", "gainesville", "cfl", "jacksonville", "lakeland", "lakecity", "ocala", "okaloosa", "orlando", "panamacity", "pensacola", "sarasota", "miami", "spacecoast", "staugustine", "tallahassee", "tampa", "treasure", "westpalmbeach", "albanyga", "athensga", "atlanta", "augusta", "brunswick", "columbusga", "macon", "nwga", "savannah", "statesboro", "valdosta", "honolulu", "boise", "eastidaho", "lewiston", "twinfalls", "bn", "chambana", "chicago", "decatur", "lasalle", "mattoon", "peoria", "rockford", "carbondale", "springfieldil", "quincy", "bloomington", "evansville", "fortwayne", "indianapolis", "kokomo", "tippecanoe", "muncie", "richmondin", "southbend", "terrehaute", "ames", "cedarrapids", "desmoines", "dubuque", "fortdodge", "iowacity", "masoncity", "quadcities", "siouxcity", "ottumwa", "waterloo", "lawrence", "ksu", "nwks", "salina", "seks", "swks", "topeka", "wichita", "bgky", "eastky", "lexington", "louisville", "owensboro", "westky", "batonrouge", "cenla", "houma", "lafayette", "lakecharles", "monroe", "neworleans", "shreveport", "maine", "annapolis", "baltimore", "easternshore", "frederick", "smd", "westmd", "boston", "capecod", "southcoast", "westernmass", "worcester", "annarbor", "battlecreek", "centralmich", "detroit", "flint", "grandrapids", "holland", "jxn", "kalamazoo", "lansing", "monroemi", "muskegon", "nmi", "porthuron", "saginaw", "swmi", "thumb", "up", "bemidji", "brainerd", "duluth", "mankato", "minneapolis", "rmn", "marshall", "stcloud", "gulfport", "hattiesburg", "jackson", "meridian", "northmiss", "natchez", "columbiamo", "joplin", "kansascity", "kirksville", "loz", "semo", "springfield", "stjoseph", "stlouis", "billings", "bozeman", "butte", "greatfalls", "helena", "kalispell", "missoula", "montana", "grandisland", "lincoln", "northplatte", "omaha", "scottsbluff", "elko", "lasvegas", "reno", "nh", "cnj", "jerseyshore", "newjersey", "southjersey", "albuquerque", "clovis", "farmington", "lascruces", "roswell", "santafe", "albany", "binghamton", "buffalo", "catskills", "chautauqua", "elmira", "fingerlakes", "glensfalls", "hudsonvalley", "ithaca", "longisland", "newyork", "oneonta", "plattsburgh", "potsdam", "rochester", "syracuse", "twintiers", "utica", "watertown", "asheville", "boone", "charlotte", "eastnc", "fayetteville", "greensboro", "hickory", "onslow", "outerbanks", "raleigh", "wilmington", "winstonsalem", "bismarck", "fargo", "grandforks", "nd", "akroncanton", "ashtabula", "athensohio", "chillicothe", "cincinnati", "cleveland", "columbus", "dayton", "limaohio", "mansfield", "sandusky", "toledo", "tuscarawas", "youngstown", "zanesville", "lawton", "enid", "oklahomacity", "stillwater", "tulsa", "bend", "corvallis", "eastoregon", "eugene", "klamath", "medford", "oregoncoast", "portland", "roseburg", "salem", "altoona", "chambersburg", "erie", "harrisburg", "lancaster", "allentown", "meadville", "philadelphia", "pittsburgh", "poconos", "reading", "scranton", "pennstate", "williamsport", "york", "providence", "charleston", "columbia", "florencesc", "greenville", "hiltonhead", "myrtlebeach", "nesd", "csd", "rapidcity", "siouxfalls", "sd", "chattanooga", "clarksville", "cookeville", "jacksontn", "knoxville", "memphis", "nashville", "tricities", "abilene", "amarillo", "austin", "beaumont", "brownsville", "collegestation", "corpuschristi", "dallas", "nacogdoches", "delrio", "elpaso", "galveston", "houston", "killeen", "laredo", "lubbock", "mcallen", "odessa", "sanangelo", "sanantonio", "sanmarcos", "bigbend", "texoma", "easttexas", "victoriatx", "waco", "wichitafalls", "logan", "ogden", "provo", "saltlakecity", "stgeorge", "burlington", "charlottesville", "danville", "fredericksburg", "norfolk", "harrisonburg", "lynchburg", "blacksburg", "richmond", "roanoke", "swva", "winchester", "bellingham", "kpr", "moseslake", "olympic", "pullman", "seattle", "skagit", "spokane", "wenatchee", "yakima", "charlestonwv", "martinsburg", "huntington", "morgantown", "wheeling", "parkersburg", "swv", "wv", "appleton", "eauclaire", "greenbay", "janesville", "racine", "lacrosse", "madison", "milwaukee", "northernwi", "sheboygan", "wausau", "wyoming", "micronesia", "puertorico", "virgin", "brussels", "bulgaria", "zagreb", "copenhagen", "bordeaux", "rennes", "grenoble", "lille", "loire", "lyon", "marseilles", "montpellier", "cotedazur", "rouen", "paris", "strasbourg", "toulouse", "budapest", "reykjavik", "dublin", "luxembourg", "amsterdam", "oslo", "bucharest", "moscow", "stpetersburg", "ukraine", "bangladesh", "micronesia", "jakarta", "tehran", "baghdad", "haifa", "jerusalem", "telaviv", "ramallah", "kuwait", "beirut", "malaysia", "pakistan", "dubai", "vietnam", "auckland", "christchurch", "wellington", "buenosaires", "lapaz", "belohorizonte", "brasilia", "curitiba", "fortaleza", "portoalegre", "recife", "rio", "salvador", "saopaulo", "caribbean", "santiago", "colombia", "costarica", "santodomingo", "quito", "elsalvador", "guatemala", "managua", "panama", "lima", "puertorico", "montevideo", "caracas", "virgin", "cairo", "addisababa", "accra", "kenya", "casablanca", "tunis"]

  VALID_FIELDS = [:query, :srchType]

  ERRORS = [OpenURI::HTTPError]

  def search_city_jobs( options ={city: city}, query)
    uri = "http://#{options[:city]}.craigslist.org/search/jjj?query=" + query.split(' ').join("&")
    nokogiri_scrape(uri, options)
  end

  def search(options ={})
    if options[:title_only]
      options.merge!(srchType: "T")
      options.delete(:title_only)
    end
    uri = "http://#{options[:city]}.craigslist.org/search/jjj?#{to_query(options)}"

    nokogiri_scrape(uri)

  end

  def nokogiri_scrape(uri, options={})
    begin
      doc = Nokogiri::HTML(open(uri))

      doc.css('p.row').flat_map do |link|
        [
         data_id: link["data-pid"] ,
         description:  link.css("a").text,
         url: "http://#{options[:city]}.craigslist.org#{link.css("a")[0]["href"]}",
        #  price: extract_price(link.css("span.price").text)
        ]
      end
    rescue *ERRORS => e
      [{error: "error opening city: #{options[:city]}"} ]
    end
  end

  def cities
    CITIES
  end

  def method_missing(method,*args)
    binding.pry
    super unless CITIES.include? city ||= extract_city(method)

    params = { query: args.first , city: city}
    params.merge!(title_only: true) if /titles/ =~ method

    search(params)
  end

  def search_all_cities_for(query)
    CITIES.flat_map do |city|
      search(city: city , query: query)
    end
  end

  Array.class_eval do
    def average_price
      reject! { |item| item[:price] == nil }
      return 0 if empty?

      price_array.reduce(:+) / size
    end

    def median_price
      reject! { |item| item[:price] == nil }

      return 0 if empty?
      return first[:price].to_i if size == 1

      if size.odd?
        price_array.sort[middle]
      else
        price_array.sort[middle - 1.. middle].reduce(:+) / 2
      end
    end

    private

    def middle
      size / 2
    end

    def price_array
      flat_map { |item| [item[:price]] }.map { |price| price.to_i }
    end
  end

  private

  def extract_city(method_name)

    if /titles/ =~ method_name
      method_name.to_s.gsub("search_titles_in_","").gsub("_for","")
    else
      method_name.to_s.gsub("search_","").gsub("_for","")
    end
  end

  def extract_price(dollar_string)
    dollar_string[1..-1]
  end

  def to_query(hsh)
    hsh.select { |k,v| CraigsList::VALID_FIELDS.include? k }.map {|k, v| "#{k}=#{CGI::escape v}" }.join("&")
  end

end
