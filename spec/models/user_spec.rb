# == Schema Information
#
# Table name: users
#
#  id                      :integer          not null, primary key
#  first_name              :string(255)
#  last_name               :string(255)
#  is_admin                :boolean          default(FALSE)
#  telephone               :string(255)
#  email                   :string(255)
#  street_address          :text
#  city                    :string(255)
#  state                   :string(255)
#  zip_code                :string(255)
#  emergency_contact       :string(255)
#  emergency_contact_phone :string(255)
#  github_url              :string(255)
#  html_url                :string(255)
#  repos_url               :string(255)
#  gists_url               :string(255)
#  avatar_url              :string(255)
#  public_repos            :integer
#  followers               :integer
#  following               :integer
#  github_id               :integer
#  github_login            :string(255)
#  gravatar_id             :integer
#  followers_url           :string(255)
#  following_url           :string(255)
#  starred_url             :string(255)
#  subscriptions_url       :string(255)
#  organizations_url       :string(255)
#  events_url              :string(255)
#  received_events_url     :string(255)
#  type                    :string(255)
#  site_admin              :string(255)
#  public_gists            :string(255)
#  created_github_profile  :datetime
#  last_updated_github_at  :datetime
#  created_at              :datetime
#  updated_at              :datetime
#

require 'spec_helper'

describe User do
  it { should have_many :course_memberships }
  it { should have_many(:assignments).through :contributions }
  it { should have_many :contributions }
  it { should have_many(:courses).through :course_memberships }
  
  it "has a valid factory" do
  	FactoryGirl.create(:user).should be_valid
  end

  describe 'instance methods in User class' do
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

  
	  it "returns a list of homeworks in an array" do
	    @rahul.homeworks.should =~ [@rahul_hw]
	    @amal.homeworks.should =~ [@amal_hw, @amal_hw_2]
	  end

	  it "returns a list of quizzes in an array" do
	  	@amal.quizzes.should == []
	    @rahul.quizzes.should =~ [@rahul_quiz_1, @rahul_quiz_2]
	  end

	  it "returns a list of projects in an array" do
	    @amal.projects.should =~ [@amal_project_1, @amal_project_2]
	    @rahul.projects.should =~ [@rahul_project_1]
	  end

	  it "returns its role as a string" do
	    @rahul.role.should == "student"
	    @tom.role.should == "teacher"
	    @teddy.role.should == "teacher"
	    @amal.role.should == "student"
	  end

	  it "responds with true when asked if it is a student" do
	    @amal.student?.should == true
	  end

	  it "responds with false when a teacher is asked if they are a student" do
	    @tom.student?.should == false
	  end
	  
	  it "should consider only current course memberships when returning role info" do
	  	@teddy.student?.should == false
	  	@teddy.teacher?.should == true
	  end
	    
	  it "responds with true  when asked if a teacher is a teacher" do
	    @tom.teacher?.should == true
	  end

	  it "responds with false when a student is asked if they are a teacher" do
	    @amal.teacher?.should == false
	  end

	  it "returns its course" do
	    @amal.course.should == @bos_fall
	  end

	  it "returns a list of its students in an array" do
	    @tom.students.should =~ [@rahul, @amal, @cori]
	    @teddy.students.should =~ [@rahul, @amal, @cori]
	    @rahul.students.should be nil
	    @amal.students.should be nil
	  end

	  it "returns a list of all of a teacher's past courses" do
	  	@david.courses_teaching.should =~ [@nyc_summer, @bos_fall]
	  	@teddy.courses_teaching.should =~ [@bos_fall]
	  	@tom.courses_teaching.should =~ [@bos_fall]
	  end

	  it "returns a list of all students and teachers in an array" do
	  	User.teachers(@bos_fall).should =~ [@tom, @teddy, @david]
	  	User.students(@bos_fall).should =~ [@cori, @amal, @rahul]
	  end
  end

end
