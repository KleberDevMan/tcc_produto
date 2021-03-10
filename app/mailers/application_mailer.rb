class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com',
          reply_to: 'naoresponda@tccproduto.com.br'
  layout 'mailer'
end
