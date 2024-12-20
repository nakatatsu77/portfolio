require 'openai'

OpenAIClient = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])

response = OpenAIClient.images.generate(
  parameters: {
    model: "dall-e-3",
    prompt: "a white siamese cat",
    size: "1024x1024",
    quality: "standard",
    n: 1,
  }
)
puts response.dig("data", 0, "url")
