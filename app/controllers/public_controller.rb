class PublicController < ApplicationController
  layout "public"
	def index
    check_session
		@title    = 'Place sharing'
  end

  def login
    @username = security(params[:l_username])
    @password = Digest::MD5.hexdigest(params[:l_password].gsub("'", ""))
    if !params[:l_username]
      render js: "alert('please check your username')"
    else
      check_user = User.select('id, initial_name, actual_name').where(:initial_name=>@username)
      @check_username = 0
      check_user.each do |check_data_user|
        @users_id = check_data_user['id']
        @username = check_data_user['initial_name']
        @fullname = check_data_user['actual_name']
        @check_username += 1
      end
      if @check_username.to_i == 0
        render js: "alert('username not found')"
      else
        @check_password = Login.where(:users_id => @users_id , :password=>@password).count
        if @check_password.to_i == 0
          render js: "alert('please check your password')"
        else
          session[:session_userid]   = @users_id
          session[:session_username] = @username
          session[:session_fullname] = @fullname
          redirect_to("/@"+@username)
        end
      end
    end  
  end

  def register
    @username = security(params[:r_username].gsub(" ", ""))
    @fullname = security(params[:r_fullname])
    @password = Digest::MD5.hexdigest(params[:r_password].gsub("'", ""))
    if !params[:r_username]
      render js: "alert('please check your username')"
    else
      if !params[:r_fullname]
        render js: "alert('please check your fullname')"
      else
        p = params[:r_password].chomp
        if p.to_i < 6
          render js: "alert('please check your password')"
        else
          @check_username = User.where(:initial_name => @username).count
          if @check_username.to_i > 0
            render js: "alert('username already exist')"
          else
            set_user = ActiveRecord::Base.connection.execute("SELECT nextval('users_seq') as user_id")
            set_user.each do |set_data_user| 
              @users_id   = set_data_user['user_id']
            end
            User.create!(id: @users_id,initial_name: @username, actual_name: @fullname)
            Login.create!(users_id: @users_id,password: @password) 
            session[:session_userid]   = @users_id
            session[:session_username] = @username
            session[:session_fullname] = @fullname
            redirect_to("/@"+@username)
          end
        end
      end
    end  
  end

  def search
    if params[:query]
      @list_user = User.select('id, initial_name, actual_name').where('UPPER(actual_name) LIKE ?','%'+security(params[:query].upcase)+'%')
      render :partial => '/public/partial/search_users' 
    end
  end

  private 
    def check_session
      if ( session[:session_userid] != nil and session[:session_username] != nil and session[:session_fullname] != nil)
        @check_username = User.select('id, initial_name, actual_name').where(:id=>session[:session_userid]).count
        if @check_username.to_i > 0
          redirect_to("/@"+session[:session_username])
        end
      end 
    end

  private
    def security(string)
      @replace_string1 = string.gsub("~","")
      @replace_string2 = @replace_string1.gsub("@","")
      @replace_string3 = @replace_string2.gsub("%","")
      @replace_string4 = @replace_string3.gsub("&","")
      @replace_string5 = @replace_string4.gsub(".","")
      @replace_string6 = @replace_string5.gsub("#","")
      @replace_string7 = @replace_string6.gsub(",","")
      @replace_string8 = @replace_string7.gsub("*","")
      @replace_string9 = @replace_string8.gsub("+","")
      @replace_string10 = @replace_string9.gsub("!","")
      @replace_string11 = @replace_string10.gsub("^","")
      @replace_string12 = @replace_string11.gsub("?","")
      @replace_string13 = @replace_string12.gsub("(","")
      @replace_string14 = @replace_string13.gsub(")","")
      @replace_string15 = @replace_string14.gsub("[","")
      @replace_string16 = @replace_string15.gsub("]","")
      @replace_string17 = @replace_string16.gsub("|","")
      @replace_string18 = @replace_string17.gsub("'","")
      @replace_string19 = @replace_string18.gsub("`","")
      @replace_string20 = @replace_string19.gsub("<","")
      @replace_string21 = @replace_string20.gsub(">","")
      @replace_string22 = @replace_string21.gsub("-","")
      @replace_string23 = @replace_string22.gsub("/","")
    end
end