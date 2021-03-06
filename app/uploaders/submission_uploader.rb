require 'image_processing/mini_magick'

# SubmissionUploader Class
class SubmissionUploader < Shrine
  # shrine plugins
  plugin :determine_mime_type, analyzer: :marcel
  plugin :upload_endpoint, max_size: 10*1024*1024 # 10 MB
	plugin :default_storage, cache: :submission_cache, store: :submission_store
	plugin :restore_cached_data
end
