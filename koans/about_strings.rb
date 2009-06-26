require 'edgecase'

class AboutStrings < EdgeCase::Koan
  def test_double_quoted_strings_are_strings
    string = "Hello, World"
    assert string.is_a?(String)
  end

  def test_single_quoted_strings_are_also_strings
    string = 'Goodbye, World'
    assert string.is_a?(String)
  end

  def test_use_single_quotes_to_create_string_with_double_quotes
    string = 'He said, "Go Away."'
    assert_equal 'He said, "Go Away."', string
  end

  def test_use_double_quotes_to_create_strings_with_single_quotes
    string = "Don't"
    assert_equal "Don't", string
  end

  def test_use_backslash_for_those_hard_cases
    a = "He said, \"Don't\""
    b = 'He said, "Don\'t"'
    assert a == b
  end

  def test_use_flexible_quoting_to_handle_really_hard_cases
    a = %(flexible quotes can handle both ' and " characters)
    b = %!flexible quotes can handle both ' and " characters!
    c = %{flexible quotes can handle both ' and " characters}
    assert a == b
    assert a == c
  end

  def test_flexible_quotes_can_handle_multiple_lines
    long_string = %{
It was the best of times,
It was the worst of times.
}
    assert_equal 54, long_string.size
    
    # NOTE: I much prefer to use length here instead of size
    # because in Ruby size sometimes means the same thing as length, but
    # sometimes it returns the size of an object in bytes, e.g.
    #   1.size #=> 4
  end

  def test_here_documents_can_also_handle_multiple_lines
    long_string = <<EOS
It was the best of times,
It was the worst of times.
EOS
    assert_equal 53, long_string.size
  end

  def test_plus_will_concatenate_two_strings
    string = "Hello, " + "World"
    assert_equal "Hello, World", string
  end

  def test_plus_concatenation_will_leave_the_original_strings_unmodified
    hi = "Hello, "
    there = "World"
    string = hi + there
    assert_equal "Hello, ", hi
    assert_equal "World", there
  end

  def test_plus_equals_will_concatenate_to_the_end_of_a_string
    hi = "Hello, "
    there = "World"
    hi += there
    assert_equal "Hello, World", hi
  end

  def test_plus_equals_also_will_leave_the_original_string_unmodified
    original_string = "Hello, "
    hi = original_string
    there = "World"
    hi += there
    assert_equal "Hello, ", original_string
  end

  def test_the_shovel_operator_will_also_append_content_to_a_string
    hi = "Hello, "
    there = "World"
    hi << there
    assert_equal "Hello, World", hi
    assert_equal "World", there
  end

  def test_the_shovel_operator_modifies_the_original_string
    original_string = "Hello, "
    hi = original_string
    there = "World"
    hi << there
    assert_equal "Hello, World", original_string
    
    # I DO kind of know this stuff
    #
    #  http://talklikeaduck.denhaven2.com/2006/09/13/on-variables-values-and-objects
    #  
    

    # THINK ABOUT IT:
    #
    # Ruby programmers tend to favor the shovel operator (<<) over the
    # plus equals operator (+=) when building up strings.  Why?
    #
    #  << modifies the receiver string, while += creates a new String
    #  changes the lhs to refer to the new String, and assuming there are
    #  no other references to the String formerly referenced by the lhs
    #  throws the old string away (i.e. it's a candidate for GC)
    #  So << tends to be faster.
  end

  def test_double_quoted_string_interpret_escape_characters
    string = "\n"
    assert_equal 1, string.size
  end

  def test_single_quoted_string_do_not_interpret_escape_characters
    string = '\n'
    assert_equal 2, string.size
  end

  def test_single_quotes_sometimes_interpret_escape_characters
    string = '\\\''
    assert_equal 2, string.size
    assert_equal "\\'", string
  end

  def test_double_quoted_strings_interpolate_variables
    value = 123
    string = "The value is #{value}"
    assert_equal "The value is 123", string
  end

  def test_single_quoted_strings_do_not_interpolate
    value = 123
    string = 'The value is #{value}'
    assert_equal 'The value is #{value}', string
  end

  def test_any_ruby_expression_my_be_interpolated
    string = "The square root of 5 is #{Math.sqrt(5)}"
    assert_equal "The square root of 5 is " + Math.sqrt(5).to_s, string
  end

  def test_you_can_get_a_substring_from_a_string
    string = "Bacon, lettuce and tomato"
    assert_equal "let", string[7,3]
    assert_equal "let", string[7..9]
  end

  def test_you_can_get_a_single_character_from_a_string
    string = "Bacon, lettuce and tomato"
    assert_equal 97, string[1]

    # Surprised?
    #  Not for quite a long time, also in Ruby 1.9 this would be "a"
  end

  def test_single_characters_are_represented_by_integers
    assert_equal 97, ?a
    assert ?a == 97

    assert ?b == (?a + 1)
  end

  def test_strings_can_be_split
    string = "Sausage Egg Cheese"
    words = string.split
    # I hope you don't mind me using a word array literal here
    assert_equal %w[Sausage Egg Cheese], words
  end

  def test_strings_can_be_split_with_different_patterns
    string = "the:rain:in:spain"
    words = string.split(/:/)
    assert_equal %w[the rain in spain], words

    # NOTE: Patterns are formed from Regular Expressions.  Ruby has a
    # very powerful Regular Expression library.  Unfortunately, time
    # does not permit us to explore it in detail in Ruby 101.
  end

  def test_strings_can_be_joined
    words = ["Now", "is", "the", "time"]
    assert_equal "Now is the time", words.join(" ")
  end
end
