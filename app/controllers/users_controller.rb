class UsersController < ApplicationController
	before_filter :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]
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

	#   # now with instance methods!
	  # @student.one_on_ones_as_student
	  # @teacher.one_on_ones_as_teacher
	  # @course.one_on_ones
    
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
	end 
  
  def new
  	# mailer to send email invite for a student to log in?
  	@user = User.new
	end

  def callback
    result = RestClient.post("https://github.com/login/oauth/access_token", {client_id: ENV['CLIENT_ID'], client_secret: ENV['CLIENT_SECRET'], code: params[:code]}, { accept => :json });
    @@access_token = JSON.parse(result)['access_token']
    redirect_to '/users/create'
  end

  def create
    github_user = JSON.parse(RestClient.get("https://api.github.com/user", {params: {:access_token => @@access_token}}))
    user = User.where(github_login: github_user['login']).first
    unless user
      user = User.create!(
        github_login: github_user['login'],
        github_id: github_user['id'],
        github_url: github_user['url'] , 
        avatar_url: github_user['avatar_url'],
        gravatar_id: github_user['gravatar_id'] , 
        html_url: github_user['html_url'], 
        followers_url: github_user['followers_url'] ,
        following_url: github_user['following_url'] , 
        gists_url: github_user['gists_url'] , 
        starred_url: github_user['starred_url'] , 
        subscriptions_url: github_user['subscriptions_url'] , 
        organizations_url: github_user['organizations_url'] , 
        repos_url: github_user['repos_url'] , 
        events_url: github_user['events_url'] , 
        received_events_url: github_user['received_events_url'] , 
        type: github_user['type'], 
        site_admin: github_user['site_admin'] ,
        public_repos: github_user['public_repos'],
        followers: github_user['followers'] , 
        following: github_user['following'], 
        created_github_profile: github_user['created_at'] , 
        last_updated_github_at: github_user['updated_at'] , 
        public_gists: github_user['public_gists']) 
      end
    redirect_to "/sessions/#{user.id}/create"
  end

  def edit
  end

	def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end	
  end

	def destroy
		@user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
	end

	private

	def set_user
		@user = User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:first_name, :last_name, :email, :telephone, :email, :street_address, :city, :state, :zip_code, :emergency_contact, :emergency_contact_phone)
	end

end
