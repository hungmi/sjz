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

	def delete filename
		@bucket.delete_object(filename)
	end

	def download_url key, share_timeout = nil
		if @bucket.object_exists?(key)
			if share_timeout.present?
				share_timeout = (share_timeout.to_i < 86400 ? share_timeout : 86400) 
				@bucket.object_url(key, share_timeout)
			else
				@bucket.object_url(key)
			end
		end
	end
end