class LessonsController < ApplicationController
	before_action :authenticate_user!
	before_action :require_authorized_for_current_lesson, only: [:show]
	
	def show
		current_user.lessons.show(course: current_course)
		redirect_to lesson_path(current_course)
	end

	private

	def require_authorized_for_current_lesson
		if current_lesson.user != current_user
			redirect_to courses_path(current_lesson), alert: 'You Are Not Enrolled'
		end
	end

  	helper_method :current_lesson
  	def current_lesson
    	@current_lesson ||= Lesson.find(params[:id])
  	end

end
