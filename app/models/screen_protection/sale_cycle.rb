class ScreenProtection::SaleCycle < SaleCycle

  default_scope { where(kind: 'screen_protection') }

  validates :imei, presence: true, if: :imei_info?
  validates :front_photo, presence: true, if: :device_front_photo?
  validates :back_photo, presence: true, if: :device_back_photo?

  def step_availables
    %w[send_validation_link access_validation_link imei_info device_front_photo device_back_photo waiting_review]
  end
end
