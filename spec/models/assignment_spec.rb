# == Schema Information
#
# Table name: assignments
#
#  id              :integer          not null, primary key
#  course_id       :integer
#  title           :string(255)
#  description     :text
#  github_login    :string(255)
#  github_repo     :string(255)
#  due_date        :datetime
#  assignment_type :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

require 'spec_helper'

describe Assignment do
  it { should belong_to :course }
  it { should have_many :contributions}
  it { should have_many(:users).through :contributions}

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

	    it "returns true if the assignment is a quiz" do
	  	  @quiz_1.quiz.should == true
	  	  @project_1.quiz.should == false
	    end

	    it "returns true if the assignment is a homework" do
	  	  @homework_1.homework.should == true
	  	  @project_1.homework.should == false
	    end

	    it "returns true if the assignment is a project" do
	  	  @project_1.project.should == true
	  	  @homework_1.project.should == false
	    end
	  end  
end
