class StaticPagesController < PortalController
  def contact
    ContactMailer.ask_question(params[:contact]).deliver if request.post?
  end
end
