class Student
  attr_accessor :id, :name, :grade

  def self.new_from_db(row)
   student = Student.new()
   student.id = row[0]
   student.name = row[1]
   student.grade = row[2]
   student
  end

  def self.all
    sql = 'SELECT * FROM students;'
    db = DB[:conn].execute(sql)
    all_the_students = []
    db.each do |row|
      student = Student.new()
      student.id = row[0]
      student.name = row[1]
      student.grade = row[2]
      all_the_students << student
    end
    all_the_students
  end

  def self.all_students_in_grade_9
    sql = 'SELECT * FROM students WHERE grade = 9;'
    db = DB[:conn].execute(sql)
    grade_9_students = []
    db.each do |row|
      student = Student.new()
      student.id = row[0]
      student.name = row[1]
      student.grade = row[2]
      grade_9_students << student
    end
    grade_9_students
  end

  def self.all_students_in_grade_X(grade)
    sql = 'SELECT * FROM students WHERE grade = ?;'
    db = DB[:conn].execute(sql, grade)
    grade_x = []
    db.each do |row|
      student = Student.new()
      student.id = row[0]
      student.name = row[1]
      student.grade = row[2]
      grade_x << student
    end
    grade_x
  end

  def self.first_student_in_grade_10
    sql = 'SELECT * FROM students WHERE grade = 10 LIMIT 1'
    db = DB[:conn].execute(sql).flatten
    student = Student.new()
    student.id = db[0]
    student.name = db[1]
    student.grade = db[2]
    student
  end

  def self.first_X_students_in_grade_10(x)
    sql = 'SELECT * FROM students WHERE grade = 10 LIMIT ?'
    db = DB[:conn].execute(sql, x)
    first_x_students = []
    db.each do |row|
      student = Student.new()
      student.id = row[0]
      student.name = row[1]
      student.grade = row[2]
      first_x_students << student
    end
    first_x_students
  end

  def self.students_below_12th_grade
    sql = 'SELECT * FROM students WHERE grade < 12'
    db = DB[:conn].execute(sql)
    all_students_below_12 = []
    db.each do |row|
      student = Student.new()
      student.id = row[0]
      student.name = row[1]
      student.grade = row[2]
      all_students_below_12 << student
    end
    all_students_below_12
  end

  def self.find_by_name(name)
    sql = 'SELECT * FROM students WHERE name = ?'
    db = DB[:conn].execute(sql, name)
    student = Student.new()
    student.id = db[0][0]
    student.name = db[0][1]
    student.grade = db[0][2]
    student
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end

  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end
end
