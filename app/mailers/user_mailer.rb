class UserMailer < ApplicationMailer

  def new_collaboration
    @idea = params[:collaboration].idea
    @user = params[:collaboration].user

    mail to: @idea.ideializer.email,
         subject: "Novo colaborador - #{@idea.title.truncate(60)}"
  end

end
