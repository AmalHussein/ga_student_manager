# == Schema Information
#
# Table name: courses
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  location   :string(255)
#  session    :string(255)
#  start_date :datetime
#  end_date   :datetime
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Course do

  it { should have_many :course_memberships }
  it { should have_many(:users).through :course_memberships }
  it { should have_many :assignments }
  
  describe "instance methods" do 
    	before :each do
		  	@rahul = User.create
		    @amal = User.create
		    @cori = User.create
		    @xtine = User.create
		    @david = User.create
		    @tom = User.create
		    @teddy = User.create
		    @nyc_summer = Course.create(start_date: Date.today - 5.months, end_date: Date.today - 2.months)
		  	@teddy_enrolls = CourseMembership.create(user: @teddy, course: @nyc_summer, role: "student")
		  	@xtine_enrolls = CourseMembership.create(user: @xtine, course: @nyc_summer, role: "student")
		  	@david_teaches = CourseMembership.create(user: @david, course: @nyc_summer, role: "teacher")
		  	@bos_fall = Course.create(start_date: Date.today - 2.months, end_date: Date.today + 1.month)
		  	@teddy_gets_promoted = CourseMembership.create(user: @teddy, course: @bos_fall, role: "teacher")
		  	@david_teaches_again = CourseMembership.create(user: @david, course: @bos_fall, role: "teacher")
		   	@tom_becomes_a_teacher = CourseMembership.create(user: @tom, course: @bos_fall, role: "teacher")
		    CourseMembership.create(user: @rahul, course: @bos_fall, role: "student")
		    CourseMembership.create(user: @amal, course: @bos_fall, role: "student")
		    CourseMembership.create(user: @cori, course: @bos_fall, role: "student")
		    @homework_1 = Assignment.create(course: @bos_fall, assignment_type: "homework")
		    @homework_2 = Assignment.create(course: @bos_fall, assignment_type: "homework")
		    @quiz_1 = Assignment.create(course: @bos_fall, assignment_type: "quiz")
		    @quiz_2 = Assignment.create(course: @bos_fall, assignment_type: "quiz")
		    @project_1 = Assignment.create(course: @bos_fall, assignment_type: "project")
		    @project_2 = Assignment.create(course: @bos_fall, assignment_type: "project")
		    @amal_hw = Contribution.create(assignment: @homework_1, user: @amal)
		    @amal_hw_2 = Contribution.create(assignment: @homework_2, user: @amal)
		    @rahul_hw = Contribution.create(assignment: @homework_1, user: @rahul)
		    @amal_project_1 = Contribution.create(assignment: @project_1, user: @amal)
		    @rahul_quiz_1 = Contribution.create(assignment: @quiz_1, user: @rahul)
		    @amal_project_2 = Contribution.create(assignment: @project_2, user: @amal)
		    @rahul_quiz_2 = Contribution.create(assignment: @quiz_2, user: @rahul)
		    @rahul_project_1 = Contribution.create(assignment: @project_1, user: @rahul)
	    end

	    it "returns a list of quizzes in an array" do
	  	  @bos_fall.quizzes.should =~ [@quiz_1, @quiz_2]
	    end

	    it "returns a list of projects in an array" do
	  	  @bos_fall.projects.should =~ [@project_1, @project_2]
	    end

	    it "returns a list of homeworks in an array" do
	  	  @bos_fall.homeworks.should =~ [@homework_1, @homework_2]
	    end

	  end
end
