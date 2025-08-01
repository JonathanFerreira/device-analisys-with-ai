class RobberyAndTheft::SaleCycle < SaleCycle
  default_scope { where(kind: 'robbery_and_theft') }

  validates :imei, presence: true, if: :imei_info?

  def step_availables
    %w[send_validation_link access_validation_link imei_info waiting_review]
  end
end
