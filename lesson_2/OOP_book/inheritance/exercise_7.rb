class Student
  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(other)
    grade > other.grade
  end

  protected
    def grade
      @grade
    end
end

allen = Student.new("allen", 94)
bob = Student.new("bob", 81)

puts "well done!" if allen.better_grade_than?(bob)