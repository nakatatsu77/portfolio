class ImagesController < ApplicationController
  def index
    @image_url = session[:image_url]
    @error = session[:error]
  end

  def create
    prompt = params[:prompt]
    response = OpenAIClient.images.generate(
      parameters: {
        model: "dall-e-3",
        prompt: prompt,
        size: "1024x1024",
        n: 1
      }
    )

    if response.key?("error")
      session[:error] = response["error"]
    else
      session[:image_url] = response["data"][0]["url"]
      session[:error] = nil
    end

    redirect_to images_path
  end
end