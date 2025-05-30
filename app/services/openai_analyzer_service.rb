class OpenaiAnalyzerService
  def initialize(url)
    @url = url
  end

  def analyze
    return nil if @url.blank?

    client = OpenAI::Client.new
    response = client.chat(
      parameters: {
        model: "gpt-4.1-2025-04-14",
        messages: [
          {
            role: "system",
            content: "Analyze smartphone listings in detail. Return JSON only with the following structure: {
              \"chance_danificado\": 0-100,
              \"detalhes_dano\": \"detailed description of potential damage or condition\",
              \"marca\": \"brand\",
              \"modelo\": \"model\",
              \"confiabilidade_dano\": 0-100,
              \"confiabilidade_marca\": 0-100,
              \"confiabilidade_modelo\": 0-100,
            }"
          },
          {
            role: "user",
            content: "Analise detalhadamente essa foto de celular. Identifique a chance do aparelho estar danificado, marca e modelo. Inclua detalhes sobre o estado. Dê um grau de confiabilidade para as informações principais usando uma escala de 0 a 100% dentro de um json para o image nessa url: #{@url}"
          }
        ],
        temperature: 0.3,
        response_format: { type: "json_object" }
      }
    )

    # Parse the response
    begin
      JSON.parse(response.dig("choices", 0, "message", "content"))
    rescue JSON::ParserError => e
      Rails.logger.error("Failed to parse OpenAI response: #{e.message}")
      nil
    end
  end
end
