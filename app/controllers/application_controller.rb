class ApplicationController < ActionController::Base
	delegate :current_user, :user_signed_in?, to: :user_session
  helper_method :current_user, :user_signed_in?
  

	def user_session
		UserSession.new(session)		
	end


  protect_from_forgery with: :exception

  before_action do 
  	I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
  	{ locale: I18n.locale}  	
  end
  
  #irá redirecionar o usuário à pagina de login caso a sessão não seja válida.
  def require_authentication
    unless user_signed_in?
      redirect_to new_user_session_path, alert: t('flash.alert.needs_login')        
    end
  end
  
  #rá redirecionar o usuário para a página principal, com uma mensagem.
  def require_no_authentication
    if user_signed_in?
      redirect_to root_path, notice: t('flash.notice.already_logged_in')    
    end
  end


end
