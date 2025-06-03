class DeepseekAnalyserService
  def initialize(url)
    @url = url
  end

  def analyze
    client = Deepseek::Client.new(ENV['DEEPSEEK_ACCESS_TOKEN'])

    response = client.chat_completions(
      model: "deepseek-chat",
      messages: [
        { role: "system", content: system_prompt },
        { role: "user", content: user_prompt }
      ],
      response_format: {
        type: 'json_object'
      }
    )

    JSON.parse response['choices'][0]['message']['content']
  rescue JSON::ParserError => e
    message = "Failed to parse Deepseek response: #{e.message}"
    puts message
    Rails.logger.error(message)
    {}
  end

  def user_prompt
    "Analise detalhadamente essa foto de celular. Identifique a chance do aparelho estar danificado, marca e modelo. Inclua detalhes sobre o estado. Dê um grau de confiabilidade para as informações principais usando uma escala de 0 a 100% dentro de um json para o image nessa url: #{@url}"
  end

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
