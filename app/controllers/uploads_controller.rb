############################### Up'n'Link Trunk ############################### 
# Copyright (C) 2012 Jaume Sola - jaumesola.com - upnlink.com
# This software is publicly available under the GPL v3 license terms.
# You may also obtain it under alternative licenses.
# Other files packaged along this one may have a different licensing.
# See the /LICENSE file or http://jaumesola.com/licenses/upnlink.html
###############################################################################

class UploadsController < ApplicationController

  # TODO: create should not be an exception 
  # (open because cookies issue with flash)   
  before_filter :authorize, :except => [ :create, :show ]

  before_filter :admin_only, :only => [ :index, :edit, :update, :destroy ] 
  
  skip_before_filter :verify_authenticity_token, :only => :create
  
  helper_method :download_link
  
  # GET /uploads
  # GET /uploads.xml
  def index
        
    @uploads = Upload.find( :all,
      :conditions => [ 'available = ? AND expiration > ?', true, Time.now ],      
      :order => :attachment
      )
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @uploads }
    end
  end

  # SHOW IS DOWNLOAD
  # GET /uploads/1
  def show

    @upload = Upload.find(params[:id]) 
    
    if params[:h] != download_hash
       render :text => 'Invalid download link. Did you copy it correctly?'
       return
    end

    if Time.now > @upload.expiration 
       render :text => 'This download link has expired.'
       return
    end
    
    send_file @upload.attachment.url, :disposition => 'inline', :type => "application/octet-stream"
    
    #respond_to do |format|
    #  format.html # show.html.erb
    #  format.xml  { render :xml => @upload }
    #end
  end

  # NEW shows upload form
  # GET /uploads/new
  # GET /uploads/new.xml
  def new
    
    # This should be done in a cron job but just for simplicity
    # we do it here for the moment
    Upload::delete_expired
    
    if !enough_disk_space then
       flash[:notice] = "Sorry, no new uploads are possible at this moment. Please try later by reloading this page."
       render :action => :empty
       return
    else
       flash = nil
    end

    @upload = Upload.new
    
    render :action => :new
    
    #respond_to do |format|
    #  format.html # new.html.erb
    #  format.xml  { render :xml => @upload }
    #end
  end

  # GET /uploads/1/edit
  def edit
    @upload = Upload.find(params[:id])
  end

  # CREATE processes the uploaded file
  # POST /uploads
  # POST /uploads.xml
  def create

    # TODO: non-AJAX (standard HTML upload form)

    # Currently should be always true
    ajax = params.include? :Filedata
    
    if !enough_disk_space
      response = 'Sorry, no new uploads are possible at this moment. Please try later by reloading this page.'
      if ajax then response = '|' + response end
      render :text => response
      return
    end
    
    if ajax
        upload_data = {}
        upload_data[:user_id] = current_user.id
        upload_data[:attachment] = params[:Filedata]
        upload_data[:email_to] = params[:email_to]
        upload_data[:message] = params[:message]
      else
        upload_data = params[:upload]
      end
     
    @upload = current_user.uploads.build(upload_data)
    saved = @upload.save

    if ! saved
      response = 'ERROR SAVING FILE!'
      if ajax then response = '|' + response end
      render :text => response
      return
    end

    # Saved
    if ajax
        response = download_link + '|' + "File #{@upload.filename} uploaded.<br />"
        UserMailer.upload_email(@upload, download_link, response).deliver
        render :text => response
    else 
        render :action => :new
    end

  end

  # PUT /uploads/1
  # PUT /uploads/1.xml
  def update
    @upload = Upload.find(params[:id])

    respond_to do |format|
      if @upload.update_attributes(params[:upload])         
        flash[:notice] ="Upload was successfully updated."
        format.html { redirect_to :action => :index }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @upload.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /uploads/1
  # DELETE /uploads/1.xml
  def destroy
    @upload = Upload.find(params[:id])
    @upload.remove_attachment!    
    @upload.destroy

    respond_to do |format|
      format.html { redirect_to(uploads_url) }
      format.xml  { head :ok }
    end
  end
  
  def download_link
    # "file/#{@upload.id}/h?=#{download_hash}"
    url_for( :action => 'show', :id => @upload.id, :only_path => false, :h => download_hash ).gsub( '/uploads/', '/file/' )
  end
      
  def download_hash
    Digest::SHA1.hexdigest( @upload.id.to_s + 'mdW9n6Pzk5R7V7stryKJ' )[4..20]
  end
  
  def enough_disk_space
    path = Rails.application.config.upnlink_uploads_directory
    # This works for most Unix-like systems
    free_kb=`df -k #{path} | grep /dev/ | awk '{ print $4 }'`.to_i
    return free_kb > Rails.application.config.upnlink_minimum_free_disk_space_kb
  end

end