class OssService
	require 'aliyun/oss'
	def initialize
		@bucket = OSS.client.get_bucket(ENV['OSS_BUCKET_NAME'])
	end

	def upload file, filename = nil
		filename ||= file.original_filename
		@bucket.put_object("#{filename}.xls", file: file.path)
	end

	def return_download_url key
		@bucket.object_exists?(key) && @bucket.object_url(key, 3600)
	end
end