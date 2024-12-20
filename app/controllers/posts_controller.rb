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
    @post = current_user.posts.build(post_params)
    @post.image.user = current_user if @post.image.present?
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

  private

  def post_params
    params.require(:post).permit(:title, :body, image_attributes: [ :image_url, :image_url_cache, :is_generated_by_ai ]) # image_attributesによってImageモデルのデータを保存、更新できる
  end
end
