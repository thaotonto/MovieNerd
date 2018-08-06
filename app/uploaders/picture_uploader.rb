class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include Cloudinary::CarrierWave


  if Rails.env.production?
    process resize_to_fit: [Settings.movie.picture_resize_high,
      Settings.movie.picture_resize_width]
    storage :fog
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
