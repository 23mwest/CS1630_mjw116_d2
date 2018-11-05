require 'simplecov'
SimpleCov.start

require 'minitest/autorun'

require_relative 'prospect'

class GoldRushTest < Minitest::Test

  # Special Method
  # This wil run before every test to create a new prospect class
  # so we do not have to call Prospect::new for every test
  def setup
  	#gold_rush.rb 0, 1
    @p = Prospect::new 0, 1
  end

  # Simple test, creates a new Prospect class 
  # Refutes that it's nil
  # Asserts that it's of type Prospect
  def test_new_prospect_not_nil
  	refute_nil @p
  	assert_kind_of Prospect, @p
  end

  # Tests that the search_gold method returns an amount of
  # gold as an int, and that it does not exceed the maximum 
  # amount of gold for that location
  def test_search_gold
    gold = @p.search_gold(1)
    assert gold < 3
  end

  # Tests that the search_silver method returns an amount of
  # silver as an int, and that it dcoes not exceed the maximum 
  # amount of silver for that location
  def test_search_silver
  	silver = @p.search_silver(5)
  	assert silver < 10
  end


  # This test tests that the pseudo random number generator 
  # works properly.
  # For different seed values, a prospector should find different
  # amounts of gold at the same location
  def test_found_gold_random_different
    @p1 = Prospect::new 267, 1
    @p2 = Prospect::new 108, 1
    gold_1 = @p1.search_gold(3)
    gold_2 = @p2.search_gold(3)
    assert gold_1 != gold_2
  end

  # This test tests that the pseudo random number generator 
  # works properly.
  # For the same seed values, a prospector should find the
  # same amount of gold at the same location
  def test_found_gold_random_same
    @p1 = Prospect::new 17, 1
    @p2 = Prospect::new 17, 1
    gold_1 = @p1.search_gold(3)
    gold_2 = @p2.search_gold(3)
    assert gold_1 == gold_2
  end 


  # Tests that the relocate method returns a new location
  # adjacent to the one that it was passed
  # Sutter Creek (Location 0) is adjacent to Coloma (Location 1)
  # and Angels Camp (Location 2)
  def test_relocate_sutter_creek
  	new_location = @p.next_location(0)
  	assert (new_location == 2 || new_location == 1)
  end

  # Tests that the relocate method returns a new location
  # adjacent to the one that it was passed
  # Coloma (Location 1) 
  def test_relocate_coloma
  	new_location = @p.next_location(1)
  	assert (new_location.zero? || new_location == 4)
  end

  # Tests that the relocate method returns a new location
  # adjacent to the one that it was passed
  # Angels Camp (Location 2) 
  def test_relocate_angels_camp
  	new_location = @p.next_location(2)
  	assert (new_location.zero? || new_location == 3 || new_location == 4)
  end

  # Tests that the relocate method returns a new location
  # adjacent to the one that it was passed
  # Nevada City (Location 3) 
  def test_relocate_nevada_city
  	new_location = @p.next_location(3)
  	assert (new_location == 2)
  end

  # Tests that the relocate method returns a new location
  # adjacent to the one that it was passed
  # Virginia City (Location 4) 
  def test_relocate_virginia_city
  	new_location = @p.next_location(4)
  	assert (new_location == 2 || new_location == 1 || new_location == 5 || new_location == 6)
  end

  # Tests that the relocate method returns a new location
  # adjacent to the one that it was passed
  # Midas (Location 5) 
  def test_relocate_midas
  	new_location = @p.next_location(5)
  	assert (new_location == 4 || new_location == 6)
  end

  # Tests that the relocate method returns a new location
  # adjacent to the one that it was passed
  # El Dorado Canyon (Location 6) 
  def test_relocate_el_dorado_canyon
  	new_location = @p.next_location(6)
  	assert (new_location == 4 || new_location == 5)
  end

  # This test checks that the function to set the plural tense 
  # of "ounces" sets it correctly for amounts greater than 1
  def test_plural_ounces_plural
  	oz_plural = @p.plural_ounces 2	
  	assert oz_plural.eql? 'ounces'
  end

  # This test checks that the function to set the plural tense 
  # of "ounces" sets it correctly for a value of 1
  def test_plural_ounces_singular
    oz_singular = @p.plural_ounces 1
    assert oz_singular.eql? 'ounce'
  end
  
  # This Test will test that the correct output is displayed when 
  # no metals are found in Sutter Creek (Location 0)
  # Including the leading tab 
  # EDGE CASE
  def test_display_no_findings
  	assert_output("	Found no precious metals in Sutter Creek\n") {@p.display_findings 0, 0, 0}
  end 

  # This Test will check that the correct information is displayed 
  # when a prospector moves to a new location 
  # EDGE CASE
  def test_display_results
    assert_output("After 527 days Prospector #667 returned to San Fransisco with:\n\t0 ounces of gold.\n\t0 ounces of silver.\n\tHeading home with $0.00\n") {@p.display_results 667, 527, 0, 0}
  
  end
  
  # This test will check that the correct number of prospectors are sent through the 
  # map 
  def test_run_correct_number_of_prospectors 
  	prospectors = @p.run 5
  	assert prospectors == 5
  end

end

  

