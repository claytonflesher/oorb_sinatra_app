require 'json'
require File.expand_path '../test_helper.rb', __FILE__

class JSONBuilderTest < Minitest::Test

  include Rack::Test::Methods

  def setup
    @builder      = JSONBuilder.new
    @letter_feed  = ['abc', 'bcd']
    @section_feed = ['mnr nr', 'abc bc']
  end

  def test_it_has_a_LETTERS_constant
    assert JSONBuilder::LETTERS.any?
  end

  def test_it_has_a_SECTIONS_constant
    assert JSONBuilder::SECTIONS.any?
  end

  def test_build_returns_formatted_hash
    expected = {
      'letters'  => [
        ['a', 'abc'],
        ['b', 'bcd']
      ],
      'sections' => [
        ['m', 'mnr nr'],
        ['a', 'abc bc']
      ]
    }
    assert_equal expected, @builder.build(
      letters:  @letter_feed,
      sections: @section_feed
    )
  end

  def test_build_chunk
    expected = [['a', 'abc'], ['b', 'bcd']]
    assert_equal expected, @builder.build_chunk(@letter_feed)
  end
end
