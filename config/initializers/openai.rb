require "openai"

# OpenAIクライアントの初期化
OpenAIClient = OpenAI::Client.new(log_errors: true, access_token: ENV["OPENAI_API_KEY"])
