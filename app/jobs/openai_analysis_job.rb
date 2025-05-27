class OpenaiAnalysisJob < ApplicationJob
  queue_as :default

  def perform(sale_id)
    sale = Sale.find_by(id: sale_id)
    return unless sale

    sale.analyze_with_openai
  end
end
