class RobberyAndTheft::SaleCycle < SaleCycle
  default_scope { where(kind: 'robbery_and_theft') }

  def step_availables
    %w[send_validation_link access_validation_link imei_info finished]
  end
end
