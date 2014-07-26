class Encoder
  SALT = Rails.configuration.encoder_salt

  def self.encode_id(id)
    (id * Encoder::SALT).to_s(16)
  end

  def self.decode_id(id)
    id.hex / Encoder::SALT
  end
end