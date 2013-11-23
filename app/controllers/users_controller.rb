class UsersController < ApplicationController

	def index 
		# # returns all the courses ever taught by the current user
		# @courses = current_user.courses_teaching

		# @course = Course(params[:course_id])

		# # instance methods you can call on course:

		# @projects = @course.projects
		# @quizzes = @course.quizzes
		# @homeworks = @course.homeworks

  #   # one_on_ones are tricky because they belong to two users.  for now:

		# @one_on_ones = OneOnOne.where(student_id: params[:id])
		# @one_on_ones = OneOnOne.where(teacher_id: params[:id])
    
  #   # you can get an array of students with an instance method on a course:
		# @students = @course.students

		# # and you can get an array of contributions from each student by calling instance methods on the user:
		# @students.each do |student|
		#   student.quizzes
		#   student.homeworks
		#   student.projects
		# end

	end 
	
	def show
		@user = User.find(params[:id])
	end 
end
