class ScreenProtection::SaleCycle < SaleCycle

  default_scope { where(kind: 'screen_protection') }

  validates :imei, presence: true, if: :imei_info?

  def step_availables
    %w[send_validation_link access_validation_link imei_info device_photos finished]
  end
end
