class ExamAnalyzerService
  def initialize(exam_text)
    @exam_text = exam_text
  end

  def analyze
    client = Deepseek::Client.new(ENV['DEEPSEEK_ACCESS_TOKEN'])

    response = client.chat_completions(
      model: "deepseek-chat",
      messages: [
        { role: "system", content: system_prompt },
        { role: "user", content: @exam_text }
      ],
      response_format: {
        'type': 'json_object'
      }
    )

    # Parse the response
    begin
      JSON.parse(response.choices[0].message.content)
    rescue JSON::ParserError => e
      Rails.logger.error("Failed to parse Deepseek response: #{e.message}")
      nil
    end
  end

  private

  def system_prompt
    <<~PROMPT
      Analyze smartphone listings in detail. Return JSON only with the following structure.

      EXAMPLE JSON OUTPUT:
      {
        "chance_danificado": 0-100,
        "detalhes_dano": "detailed description of potential damage or condition",
        "marca": "brand",
        "modelo": "model",
        "confiabilidade_dano": 0-100,
        "confiabilidade_marca": 0-100,
        "confiabilidade_modelo": 0-100,
      }
    PROMPT
  end
end
