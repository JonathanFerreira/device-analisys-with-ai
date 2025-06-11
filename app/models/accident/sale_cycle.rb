class Accident::SaleCycle < SaleCycle
  default_scope { where(kind: 'accident') }

  validates :front_photo, presence: true, if: :device_photos?
  validates :back_photo, presence: true, if: :device_photos?

  def step_availables
    %w[send_validation_link access_validation_link imei_info device_photos finished]
  end
end
