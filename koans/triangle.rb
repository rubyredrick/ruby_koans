# Triangle Project Code.

# Triangle analyzes the lengths of the sides of a triangle
# (represented by a, b and c) and returns the type of triangle.
#
# It returns:
#   :equilateral  if all sides are equal
#   :isosceles    if exactly 2 sides are equal
#   :scalene      if no sides are equal
#
# The tests for this method can be found in
#   about_triangle_project.rb
# and
#   about_triangle_project_2.rb
#
def triangle(a, b, c)
  validate_triangle(a, b, c)
  try_permutation(a, b, c) {|res| return res}
  try_permutation(a, c, b) {|res| return res}
  # b, a, c is same as a, b, c
  try_permutation(b, c, a) {|res| return res}
  # c, a, b is same as a, c, b
  # c, b, a is same as b, c, a
  :scalene
end

# Divide and conquer!
# if b and c are both equal to a, yield :equilateral, otherwise
# if only b is equal to a yield isosceles
# if a and b are unequal don't yield
def try_permutation(a, b, c)
  if a == b
    if b == c
      yield :equilateral
    else
      yield :isosceles
    end
  end
end

def validate_triangle(a, b, c)
  raise TriangleError if [a, b, c].find {|side| side <= 0} ||
                          a >= b + c ||
                          b >= a + c ||
                          c >= a + b
end


# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
