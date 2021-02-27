class MemberController < ApplicationController
  
  layout "member"

	def index
		@title    = 'Place sharing'
    if ( session[:session_userid] == nil or session[:session_username] == nil or session[:session_fullname] == nil)
      @title     = 'Place sharing'
      @username  = security(params[:uri_segment1])
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
        @list_location = Location.select('id,users_id,dates,times,name,latitude,longitude').where(:users_id=>@users_id)
      end
      render layout:'public' , controller:'member', action:'profile'
    else
      if session[:session_username] != params[:uri_segment1]
        @title     = 'Place sharing'
        @username  = security(params[:uri_segment1])
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
          @list_location = Location.select('id,users_id,dates,times,name,latitude,longitude').where(:users_id=>@users_id)
        end
        render layout:'member' , controller:'member', action:'profile'
      end
    end
  end

  def activity
    @title     = 'Place sharing'
    @username  = security(params[:uri_segment1])
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
      @list_location = Location.select('id,users_id,dates,times,name,latitude,longitude').where(:users_id=>@users_id)
    end
  end

  def newlocation
    @location = security(params[:a_location])
    if !params[:a_location]
      render "please check your username"
    else
      Location.create!(users_id: session[:session_userid],dates: Time.now.strftime("%Y/%m/%d"),times: Time.now.strftime("%H:%M:%S"), name:@location ) 
      redirect_to("/@"+session[:session_username]+"/activity")
    end  
  end

  def logout
    session[:session_userid]   = nil
    session[:session_username] = nil
    session[:session_fullname] = nil
    redirect_to :controller => 'public'
  end

  private 
    def check_session
      if ( session[:session_userid] == nil or session[:session_username] == nil or session[:session_fullname] == nil)
        redirect_to("/")
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