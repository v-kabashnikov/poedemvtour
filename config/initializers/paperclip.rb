Paperclip::Attachment.default_options.update(
	storage: :s3,
	:s3_protocol => :https,
	path: "/:class/:attachment/:id_partition/:style/:filename",
	s3_host_name: "s3-eu-central-1.amazonaws.com",
	url: ":s3_domain_url",
	s3_credentials: {
		bucket: ENV['S3_BUCKET_NAME'],
		access_key_id: ENV['AWS_ACCESS_KEY_ID'],
		secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
	}
)