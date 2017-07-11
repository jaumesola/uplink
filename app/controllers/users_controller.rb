############################### Up'n'Link Trunk ############################### 
# Copyright (C) 2012 Jaume Sola - jaumesola.com - upnlink.com
# This software is publicly available under the GPL v3 license terms.
# You may also obtain it under alternative licenses.
# Other files packaged along this one may have a different licensing.
# See the /LICENSE file or http://jaumesola.com/licenses/upnlink.html
###############################################################################

class UsersController < ApplicationController #Clearance::UsersController
  
  # Everything here is only for the admin user
  before_filter :admin_only
     
  # GET /users
  # GET /users.xml
  def index
    @users = User.find :all, :order => :email

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new
    render :action => :new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create    
    # use a random password (rand returns a float)
    params[:user][:password] = rand.to_s
    @user = User.new(params[:user])
    
    if @user.save
      flash.now[:notice] = "User was successfully created."
      
      # Clearance forgot password process
      @user.forgot_password!
      r = ::ClearanceMailer.change_password(@user).deliver
      
      # Assume email worked, but what if not?
      flash.now[:notice] += "Change password email sent to user."
      
    elsif @user.errors.any?
       flash[:alert] = ''
       @user.errors.full_messages.each { |msg| flash.now[:alert] += msg + '. ' }
    else
      flash.now[:alert] = "There was some error while creating the user."       
    end
    
    new
  end
    
  # PUT /users/1
  # PUT /users/1.xml
  def update
    
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] ="User was successfully updated."
        format.html { redirect_to :action => :index }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
