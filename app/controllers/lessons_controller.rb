class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_course

  def show
  end

  private

  helper_method :current_lesson
  
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

  def require_authorized_for_current_course
      this_course = current_lesson.section.course

      if !current_user.enrolled_in?(this_course) && this_course.user != current_user
        redirect_to course_path(this_course), alert: 'You must first be enrolled to view this content'
    end
  end
end

