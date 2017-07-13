class OssService
	require 'aliyun/oss'
	def initialize
		@bucket = OSS.client.get_bucket(ENV['OSS_BUCKET_NAME'])
	end

	def upload file, filename = nil
		filename ||= file.original_filename
		# file_ext = file.original_filename[/\.[0-9a-z]+$/i]
		@bucket.put_object(filename, file: file.path)
	end

	def download_url key
		@bucket.object_exists?(key) && @bucket.object_url(key, 3600)
	end
end