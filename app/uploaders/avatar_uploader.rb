# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base
  after :store, :remove_original_file

  def remove_original_file(p)
    if self.version_name.nil?
      self.file.delete if self.file.exists?
    end
  end
  
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  #include CarrierWave::Uploader::MagicMimeWhitelist

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  process :fix_exif_rotation
  process :crop
  process :strip
  process interlace: "Plane"
  process quality: 75
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :small do
    process resize_to_fill: [100, 100]
  end
  version :large do
    process resize_to_fill: [400, 400]
  end

  def crop
    if model.crop_x.present?
      manipulate! do |img|
        x = model.crop_x.to_s
        y = model.crop_y.to_s
        w = model.crop_w.to_s
        h = model.crop_h.to_s
        size = w << 'x' << h
        offset = '+' << x << '+' << y
        img = img.crop("#{size}#{offset}")
      end
    end
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  # def whitelist_mime_type_pattern
  #   /image\/(jpg|jpeg|pjpeg|png)/
  # end

  protected
    def secure_token
      var = :"@#{mounted_as}_secure_token"
      model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
    end

end
