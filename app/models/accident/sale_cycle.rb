class Accident::SaleCycle < SaleCycle
  default_scope { where(kind: 'accident') }

  def step_availables
    %w[send_validation_link access_validation_link imei_info device_photos finished]
  end
end
