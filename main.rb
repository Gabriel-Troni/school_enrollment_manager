class Main
    def main
        students = Array.new
        puts "Welcome to the University System"
        while true
            puts "Please, select an option:"
            puts "1. Register a new student"
            puts "2. Enroll a student in a subject"
            puts "3. Cancel a student's enrollment in a subject"
            puts "4. Print student information"
            puts "5. Print all students information"
            puts "6. Exit \n\n"
            
            option = gets.chomp.to_i
            
            case option
            when 1 
                register_student(students)
            when 2
                enroll_student(students)
            when 3
                cancel_enrollment(students)
            when 4
                print_information(students)
            when 5
                print_all_information(students)
            when 6
                puts "Thanks for visiting us!"
                break
            else
                puts "Invalid option. Please, try again."
            end
        end
    end
    
    def register_student(students)
        puts "Enter the required information:"
        print "Student's Name: "
        name = gets.chomp
                    
        print "Enrollment code: "
        enrollment = gets.chomp
                
        print "Course: "
        course = gets.chomp
                    
        print "Maximum limit of enrollments in subjects: "
        allowed_subject_quantity = gets.chomp
                    
        print "Period: "
        period = gets.chomp
                    
        print "Address: "
        address = gets.chomp
                
        students.push(Student.new(name, enrollment, course, allowed_subject_quantity.to_i, period, address))
        puts "\nStudent #{name} was enrolled successfully! \n\n"
    end
    
    def enroll_student(students)
        puts "Enter the student's enrollment code:"
        enrollment_code = gets.chomp
        
        for student in students
            if student.enrollment == enrollment_code
                puts "Enter the subject:"
                subject = gets.chomp
                student.make_enrollment(subject)
                return true
            end
        end
        puts "Student with enrollment code '#{enrollment_code}' not found\n\n"
        return false
    end
    
    def cancel_enrollment(students)
        puts "Enter the student's enrollment code:"
        enrollment_code = gets.chomp
        
        for student in students
            if student.enrollment == enrollment_code
                puts "Enter the subject:"
                subject = gets.chomp
                student.cancel_enrollment(subject)
                return true
            end
        end
        puts "Student with enrollment code '#{enrollment_code}' not found\n\n"
        return false
    end
    
    def print_information(students)
        puts "Enter the student's enrollment code:"
        enrollment_code = gets.chomp
        
        for student in students
            if student.enrollment == enrollment_code
                student.print_information
                return true
            end
        end
        puts "Student with enrollment code '#{enrollment_code}' not found\n\n"
        return false
    end
    
    def print_all_information(students)
        for student in students
            student.print_information
        end
    end
end

class Student
    attr_accessor :name, :enrollment, :course, :period, :address, :enrolled_subjects_number
    
    def initialize(name, enrollment, course, allowed_subject_quantity, period, address)
        @name = name
        @enrollment = enrollment
        @course = course
        @enrolled_subjects = Array.new(allowed_subject_quantity)
        @period = period
        @address = address
        @enrolled_subjects_number = 0
    end
    
    def make_enrollment(subject)
        if @enrolled_subjects.length == 0
            puts "Error: This student cannot be enrolled in any subject.\n\n"
            return false
        end

        if @enrolled_subjects.include?(subject)
            puts "Error: This student is already enrolled in this subject.\n\n"
            return false
        end
        
        if @enrolled_subjects.length == @enrolled_subjects_number
            puts "Error: This student have reached his limit of enrollments (#{@enrolled_subjects.length})\n\n"
            return false
        end
        
        @enrolled_subjects[@enrolled_subjects_number] = subject
        @enrolled_subjects_number += 1
        puts "#{@name} was enrolled at #{subject} successfully\n\n"
        return true
    end
    
    def cancel_enrollment(subject)
        for i in 0..@enrolled_subjects.length-1
            if @enrolled_subjects[i] == subject
                aux = i
                while @enrolled_subjects[aux+1] != nil
                    aux += 1
                end
                @enrolled_subjects[i] = @enrolled_subjects[aux]
                @enrolled_subjects[aux] = nil
                @enrolled_subjects_number -= 1
                puts "Enrollment of #{@name} at #{subject} was successfully canceled.\n\n"
                return true
            end
        end
        puts "Error: This student is not enrolled in this subject.\n\n"
        return false
    end
    
    def print_information
        puts "------------------------------------------"
        puts "Student name: #{@name}"
        puts "Enrollment: #{@enrollment}"
        puts "Course: #{@course}"
        puts "Period: #{@period}"
        puts "Enrolled subjects:"
        for i in 0..@enrolled_subjects.length-1
            if @enrolled_subjects[i] != nil
                puts "#{i+1}. #{@enrolled_subjects[i]}"
            end
        end
        puts "------------------------------------------\n\n"
    end
end

Main.new.main