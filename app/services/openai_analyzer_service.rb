class OpenaiAnalyzerService
  def initialize(url)
    @url = url
  end

  def analyze
    return nil if @url.blank?

    client = OpenAI::Client.new
    response = client.chat(
      parameters: {
        model: "gpt-4-0125-preview",
        messages: [
          {
            role: "system",
            content: "Analyze smartphone listings. Return JSON only: {\"chance_danificado\": 0-100, \"marca\": \"brand\", \"modelo\": \"model\", \"confiabilidade_dano\": 0-100, \"confiabilidade_marca\": 0-100, \"confiabilidade_modelo\": 0-100}."
          },
          {
            role: "user",
            content: "Me diga qual a chance do aparelho celular estar danificado, qual a marca e o modelo. Dê um grau de confiabilidade para cada uma dessas informações usando uma escala de 0 a 100% dentro de um json para o seguinte anúncio: #{@url}"
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
