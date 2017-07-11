require 'aliyun/oss'
module OSS
  def self.client
    unless @client
      Aliyun::Common::Logging.set_log_file('./log/oss_sdk.log')
      @client = Aliyun::OSS::Client.new(
        endpoint:
          ENV['OSS_END_POINT'],
        access_key_id:
          ENV['OSS_ACCESS_KEY_ID'],
        access_key_secret:
          ENV['OSS_ACCESS_KEY_SECRET']
      )
    end
    @client
  end
end