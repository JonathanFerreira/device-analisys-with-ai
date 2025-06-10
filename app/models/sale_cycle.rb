class SaleCycle < ApplicationRecord
  belongs_to :sale

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

    update(step: next_step)
  end

  def step_send_validation_link?
    step == 'send_validation_link'
  end

  def first_step?
    current_step_index.zero?
  end
end
