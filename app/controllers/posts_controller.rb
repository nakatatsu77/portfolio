class PostsController < ApplicationController
  def index
    @posts = Post.includes(:user)
  end

  def new
    @post = Post.new
    # postモデルに'has_one :image'の関連付けを行っている
    # 関連するImageオブジェクトを作成して@postに関連付ける。
    @post.build_image
  end

  def create
    Rails.logger.debug "Full Params: #{params.inspect}"
    @post = current_user.posts.build(post_params)
    # @post.image.user = current_user if @post.image.present?

    prompt = @post.body # bodyの内容をpromptとして利用する
    if prompt.present?
      begin
        response = OpenAIClient.images.generate(
          parameters: {
            model: "dall-e-3",
            prompt: prompt,
            size: "1024x1024",
            n: 1
          }
        )
  
        if response.key?("data")
          image_url = response["data"][0]["url"]
          @post.build_image(image_url: image_url, user: current_user)
        else
          flash.now[:danger] = "画像生成に失敗しました: #{response['error']['message']}"
          render :new, status: :unprocessable_entity
          return
        end
      rescue => e
        Rails.logger.error "OpenAI API Error: #{e.message}"
        flash.now[:danger] = "画像生成中にエラーが発生しました。"
        render :new, status: :unprocessable_entity
        return
      end
    else
      flash.now[:danger] = "本文を入力してください。"
      render :new, status: :unprocessable_entity
      return
    end
    Rails.logger.debug "Filtered Post Params: #{post_params.inspect}"

    if @post.save
      redirect_to posts_path, success: t("defaults.flash_message.created", item: Post.model_name.human)
    else
      Rails.logger.debug "Post Errors: #{@post.errors.full_messages}" # エラーをログに表示
      flash.now[:danger] = @post.errors.full_messages.join(", ") # エラーメッセージを表示
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), success: t("defaults.flash_message.updated", item: Post.model_name.human)
    else
      flash.now[:danger] = t("defaults.flash_message.not_updated", item: Post.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy!
    redirect_to posts_path, status: :see_other, success: t("defaults.flash_message.deleted", item: Post.model_name.human)
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, image_attributes: [ :image_url, :image_url_cache, :is_generated_by_ai, :id, :_destroy ]) # image_attributesによってImageモデルのデータを保存、更新できる
  end
end
