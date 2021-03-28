class PagesController < ApplicationController
  layout 'devise_layout'

  def denied
  end

  def homepage
    if current_user.nil?
      redirect_to new_user_session_path
    else
      profiles_s = current_user.profiles.map(&:namespace)

      if profiles_s.include? 'admin'
        redirect_to academic_works_path
      elsif profiles_s.include? 'archiver'
        redirect_to academic_works_path
      elsif profiles_s.include? 'collaborator'
        redirect_to ideas_path
      elsif profiles_s.include? 'ideializer'
        redirect_to my_ideas_ideas_path
      else
        render "pages/denied", layout: 'devise_layout'
      end
    end
  end

  def terms_of_use
  end
end
