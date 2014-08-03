if Rails.env == "production"
     # set credentials from ENV hash
 S3_CREDENTIALS = { :access_key_id => ENV['AKIAJFGHKNLOQ2YIKRFA'], :secret_access_key => ENV['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'], :bucket => "heydoggyimages_standard"}
 end