class Sale < ApplicationRecord
  has_many :sale_cycles, dependent: :destroy

  validates :title, presence: true
  validates :url, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]), message: "must be a valid HTTP(S) URL" }, allow_blank: true

  def analyze_with_openai
    return if url.blank?

    analysis_result = OpenaiAnalyzerService.new(url).analyze
    return unless analysis_result

    update(
      analysis: analysis_result,
      analyzed_at: Time.current
    )
  end

  def analyze_with_openai_later
    OpenaiAnalysisJob.perform_later(id)
  end

  def damage_probability
    analysis&.dig("chance_danificado")
  end

  def brand
    analysis&.dig("marca")
  end

  def model
    analysis&.dig("modelo")
  end

  def damage_confidence
    analysis&.dig("confiabilidade_dano")
  end

  def brand_confidence
    analysis&.dig("confiabilidade_marca")
  end

  def model_confidence
    analysis&.dig("confiabilidade_modelo")
  end

  def status_availables
    %w[pending rejected approved manual_review]
  end
end
