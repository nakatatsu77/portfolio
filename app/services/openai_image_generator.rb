class OpenaiImageGenerator
  def self.generate_image(prompt)
    response = OpenAIClient.images.generate(
      parameters: {
        model: "dall-e-3",
        prompt: prompt,
        size: "1024x1024",
        quality: "standard",
        n: 1
      }
    )
    Rails.logger.debug "OpenAI Response: #{response.inspect}" # レスポンスをログに表示
    response.dig("data", 0, "url") # 生成された画像URLを返す
    rescue StandardError => e
      Rails.logger.error "OpenAI Image Generation Error: #{e.message}"
      nil
    end
end
