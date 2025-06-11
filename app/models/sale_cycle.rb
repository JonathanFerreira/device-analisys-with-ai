class SaleCycle < ApplicationRecord
  belongs_to :sale

  has_one_attached :front_photo
  has_one_attached :back_photo

  def specialized_instance
    @specialized_instance = "#{kind}/sale_cycle".camelize.constantize.find(id)
  end

  def current_step_index
    step_availables.index(step)
  end

  def next_step
    step_availables[current_step_index + 1]
  end

  def next_step!
    return if next_step.blank?

    update_attribute(:step, next_step)
  end

  def step_send_validation_link?
    step == 'send_validation_link'
  end

  def first_step?
    current_step_index.zero?
  end

  def first_step!
    update_attribute(:step, step_availables.first)
  end

  def device_photos?
    step == 'device_photos'
  end
end
