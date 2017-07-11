############################### Up'n'Link Trunk ############################### 
# Copyright (C) 2012 Jaume Sola - jaumesola.com - upnlink.com
# This software is publicly available under the GPL v3 license terms.
# You may also obtain it under alternative licenses.
# Other files packaged along this one may have a different licensing.
# See the /LICENSE file or http://jaumesola.com/licenses/upnlink.html
###############################################################################

# encoding: utf-8

class AttachmentUploader < CarrierWave::Uploader::Base

  # Include RMagick or ImageScience support:
  # include CarrierWave::RMagick
  # include CarrierWave::ImageScience

  # Don't overload the disk by copy & delete, 
  # instead just move the uploaded file
  def move_to_store
    true
  end

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :s3

  def cache_dir
    Rails.application.config.upnlink_uploads_directory + "/tmp"
  end    

  # Override the directory where uploaded files will be stored.
  def store_dir
     Rails.application.config.upnlink_uploads_directory + "/#{model.id}"
  end

  def remove!
    
    super
    
    # remove also store_dir after the file has been removed
    d = store_dir
    if File.directory?(d) and (Dir.entries(d) - %w[ . .. ]).empty? then
      Dir.rmdir d
    end
    
  end


  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :scale => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # def filename
  #   "something.jpg" if original_filename
  # end

end
