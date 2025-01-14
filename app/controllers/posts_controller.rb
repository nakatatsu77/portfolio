class PostsController < ApplicationController
  # 設定したprepare_meta_tagsをprivateにあってもpostコントローラー以外にも使えるようにする
  helper_method :prepare_meta_tags

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
    # 画像生成ロジックをスキップし、通常の投稿を処理
    if @post.image.present? && !params[:generate_image].present?
      @post.image.user = current_user
    end

    # 「画像を生成して投稿する」ボタンが押された場合
    if params[:generate_image].present? && @post.body.present?
      # bodyの内容をプロンプトとして渡す
      generated_image_url = OpenaiImageGenerator.generate_image(@post.body)
      if generated_image_url
        # Postに関連付けられたImageオブジェクトのimage_urlを設定
        @post.build_image(remote_image_url: generated_image_url, is_generated_by_ai: true, user: current_user)
      else
        flash.now[:danger] = "画像生成に失敗しました。もう一度お試しください。"
        render :new and return
      end
    end

    if @post.save
      redirect_to posts_path, success: t("defaults.flash_message.created", item: Post.model_name.human)
    else
      Rails.logger.debug "Post Errors: #{@post.errors.full_messages}"
      flash.now[:danger] = @post.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
    # メタタグを設定する。
    prepare_meta_tags(@post)
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

  def prepare_meta_tags(post)
        # このimage_urlにMiniMagickで設定したOGPの生成した合成画像を代入する
        image_url = "#{request.base_url}/images/ogp.png?text=#{CGI.escape(post.body)}"
        set_meta_tags og: {
                        site_name: "バイトやらかしにっき",
                        title: post.body,
                        description: "職場でのやらかしエピソードの投稿です",
                        type: "website",
                        url: request.original_url,
                        image: image_url,
                        locale: "ja-JP"
                      },
                      twitter: {
                        card: "summary_large_image",
                        site: "@https://x.com/WebTatsuya0707",
                        image: image_url
                      }
      end
end
