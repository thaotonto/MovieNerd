class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  if Rails.env.production?
    include Cloudinary::CarrierWave
    version :standard do
      process resize_to_fit: [Settings.movie.picture_resize_high,
        Settings.movie.picture_resize_width]
    end
  else
    process resize_to_limit: [Settings.movie.picture_resize_high,
      Settings.movie.picture_resize_width]
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
