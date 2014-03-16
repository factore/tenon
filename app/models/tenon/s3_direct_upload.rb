require 'tenon/s3_signature'
module Tenon
  class S3DirectUpload
    include S3SwfUpload::Signature
    attr_accessor :bucket, :access_key_id, :secret_access_key, :options

    def initialize(opts = {})
      self.options           = default_options.merge(opts.symbolize_keys)

      config                 = YAML.load_file(options[:config_file])
      self.bucket            = config[Rails.env]['bucket']
      self.access_key_id     = config[Rails.env]['access_key_id']
      self.secret_access_key = config[Rails.env]['secret_access_key']
    end

    def post_params
      {
        'key' => "#{options[:key]}/#{time}-${filename}",
        'AWSAccessKeyId' => "#{access_key_id}",
        'acl' => "#{options[:acl]}",
        'policy' => "#{policy}",
        'signature' => "#{signature}",
        'success_action_status' => '201',
        '__utma' => '1',
        '__utmb' => '1',
        '__utmc' => '1',
        '__utmz' => '1',
        'auth_token' => '1'
      }
    end

    def upload_url
      "http://#{bucket}.s3.amazonaws.com/"
    end

    private

    def default_options
      {
        config_file: File.join(Rails.root, 'config', 's3.yml'),
        key: 'videos',
        acl: 'public-read',
        expiration_date: 10.hours.from_now.utc.strftime('%Y-%m-%dT%H:%M:%S.000Z'),
        max_filesize: 2.gigabyte
      }
    end

    def policy
      Base64.encode64(
        "{'expiration': '#{options[:expiration_date]}',
          'conditions': [
            {'bucket': '#{bucket}'},
            ['starts-with', '$key', '#{options[:key]}'],
            {'acl': '#{options[:acl]}'},
            {'success_action_status': '201'},
            ['starts-with', '$Filename', ''],
            ['starts-with', '$__utmz', ''],
            ['starts-with', '$__utma', ''],
            ['starts-with', '$__utmc', ''],
            ['starts-with', '$__utmb', ''],
            ['starts-with', '$auth_token', ''],
            ['content-length-range', 0, #{options[:max_filesize]}],
          ]
        }").gsub(/\n|\r/, '')
    end

    def signature
      b64_hmac_sha1(secret_access_key, policy)
    end

    def time
      time = Digest::MD5.hexdigest(Time.now.to_s)
    end
  end
end
