# This class will instantiate a psuedo random number generator
# and run a simulation of a specified number of prospectors
# through a map searching for gold and silver
class Prospect
  GOLD_SUTTER_CREEK = 2
  GOLD_COLOMA = 3
  GOLD_ANGELS_CAMP = 4
  GOLD_NEVADA_CITY = 5
  GOLD_VIRGINIA_CITY = 3
  GOLD_MIDAS = 0
  GOLD_EL_DORADO_CANYON = 0

  SILVER_SUTTER_CREEK = 0
  SILVER_COLOMA = 0
  SILVER_ANGELS_CAMP = 0
  SILVER_NEVADA_CITY = 0
  SILVER_VIRGINIA_CITY = 3
  SILVER_MIDAS = 5
  SILVER_EL_DORADO_CANYON = 10

  SUTTER_CREEK_NEIGHBORS = [1, 2].freeze
  COLOMA_NEIGHBORS = [0, 4].freeze
  ANGELS_CAMP_NEIGHBORS = [0, 3, 4].freeze
  NEVADA_CITY_NEIGHBORS = [2].freeze
  VIRGINIA_CITY_NEIGHBORS = [1, 2, 5, 6].freeze
  MIDAS_NEIGHBORS = [4, 6].freeze
  EL_DORADO_CANYON_NEIGHBORS = [4, 5].freeze

  SEARCH_LOCATIONS = ['Sutter Creek', 'Coloma',
                      'Angels Camp', 'Nevada City',
                      'Virginia City', 'Midas', 'El Dorado Canyon'].freeze

  def initialize(seed, num_prospectors)
    @seed = seed
    @num_prospectors = num_prospectors
    srand(@seed)
  end

  def run(num_prospectors)
    prospector = 0
    location_count = 0
    day_count = 0
    location = 0
    found_gold = 0
    found_silver = 0
    total_gold = 0
    total_silver = 0

    while prospector < num_prospectors
      puts "\nProspector #' + prospector.to_s + ' starting in Sutter Creek"
      while location_count < 5
        found_gold = search_gold(location)
        total_gold += found_gold
        found_silver = search_silver(location)
        total_silver += found_silver
        display_findings(location, found_gold, found_silver)
        if (found_gold.zero? && found_silver.zero? && location_count <= 3) ||
           (found_gold < 2 && found_silver < 3 && location_count > 3)
          location = relocate(location, total_gold, total_silver)
          location_count += 1
        end
        day_count += 1
      end
      display_results(prospector, day_count, total_gold, total_silver)
      prospector += 1
      total_gold = 0
      total_silver = 0
      location_count = 0
      day_count = 0
      location = 0
    end

    prospector
  end	

  def search_gold(loc)
    max_gold = [2, 3, 4, 5, 5, 0, 0]
    rand(max_gold[loc] + 1)
  end

  def search_silver(loc)
    max_silver = [0, 0, 0, 0, 3, 5, 10]
    rand(max_silver[loc] + 1)
  end

  def relocate(loc, gold, silver)
    prev_location = loc
    next_location = next_location(loc)
    puts 'Heading from ' + SEARCH_LOCATIONS[prev_location] + ' to ' +
         SEARCH_LOCATIONS[next_location] + '. Holding ' + gold.to_s +
         ' ' + plural_ounces(gold).to_s + ' of gold and ' +
         silver.to_s + ' ' + plural_ounces(silver).to_s + ' of silver.'
    next_location
  end

  def next_location(loc)
    case loc
    when 0
      SUTTER_CREEK_NEIGHBORS[rand(0..1)]
    when 1
      COLOMA_NEIGHBORS[rand(0..1)]
    when 2
      ANGELS_CAMP_NEIGHBORS[rand(0..2)]
    when 3
      NEVADA_CITY_NEIGHBORS[0]
    when 4
      VIRGINIA_CITY_NEIGHBORS[rand(0..3)]
    when 5
      MIDAS_NEIGHBORS[rand(0..1)]
    when 6
      EL_DORADO_CANYON_NEIGHBORS[rand(0..1)]
    else
      0
    end
  end

  def display_findings(loc, gold, silver)
    if gold > 0
      puts '	Found ' + gold.to_s + ' ' + plural_ounces(gold).to_s +
           ' of gold at ' + SEARCH_LOCATIONS[loc]
    end

    if silver > 0
      puts '	Found ' + silver.to_s + ' ' + plural_ounces(silver).to_s +
           ' of silver at ' + SEARCH_LOCATIONS[loc]
    end

    return unless gold.zero? && silver.zero?

    puts '	Found no precious metals in ' + SEARCH_LOCATIONS[loc]
  end

  def display_results(pro, days, gold, silver)
    cash_money_dolla_billz = gold * 20.67 + silver * 1.31

    puts 'After ' + days.to_s + ' days ' + 'Prospector #' + pro.to_s +
         ' returned to San Fransisco with:'
    puts '	' + gold.to_s + ' ' + plural_ounces(gold) + ' of gold.'
    puts '	' + silver.to_s + ' ' + plural_ounces(silver) + ' of silver.'
    puts '	' + 'Heading home with $' + format('%.2f', cash_money_dolla_billz).to_s

    cash_money_dolla_billz
  end

  def plural_ounces(weight)
    if weight == 1
      'ounce'
    else
      'ounces'
    end
  end
end