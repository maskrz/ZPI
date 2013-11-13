class ContactMailer < ActionMailer::Base
  def ask_question(asker)
    @asker = asker
    mail(to: 'bok@gpwanalizer.pl', subject: 'Pytanie od klienta', from: @asker[:last_name]+' '+@asker[:first_name]+' <'+@asker[:email]+'>')
  end
end
