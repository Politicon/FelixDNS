Felixdns::App.controllers  do


  get :index do
    render 'index'
  end


  post :login do
    if account = Account.authenticate(params[:email], params[:password])
      logger.info "login successful - username:" + params[:email]
      set_current_account(account)
      flash[:success] = "Login succesful!"
      redirect url(:dashboard, :index)
    elsif Padrino.env == :development && params[:bypass]
      account = Account.first
      logger.info "login bypassed"
      set_current_account(account)
      flash[:notice] = "Login bypassed!"
      redirect url(:dashboard, :index)
    else
      params[:email] = h(params[:email])
      logger.info "login failed - username:" + params[:email]
      flash[:error] = pat('login.error')
      redirect url(:dashboard, :index)
    end
  end

  get :logout do

    logger.info "logout"
    flash[:success] = "logout succesful!"
    set_current_account(nil)
    redirect url(:index)
  end



  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end


end


Felixdns::App.controllers :dashboard do

  get :index do

    render 'overview', :layout => nil
  end



end
