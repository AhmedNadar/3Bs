class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_post_redirect , only: [:show]
  before_action :http_basic_authenticate_with, only: [:admin, :new, :edit, :update, :destroy]


  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.paginate(page: params[:page], per_page: 2)
    @title = Post.all
  end

  # GET /posts for Admin
  def admin
    @posts = Post.paginate(page: params[:page], per_page: 3)
    @title = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :slug, :intro, :content)
    end

    def set_post_redirect
      # Use callbacks to share common setup or constraints between actions.
      @post = Post.friendly.find(params[:id])

      # If an old id or a numeric id was used to find the record, then
      # the request path will not match the post_path, and we should do
      # a 301 redirect that uses the current friendly id.
      if request.path != post_path(@post)
        redirect_to @post, status: :moved_permanently
      end
    end
  protected
    def http_basic_authenticate_with
      authenticate_or_request_with_http_basic do |name, password|
        if(name == ENV["BLOG_USERNAME"] && password == ENV["BLOG_PASSWORD"])
          true
        else
          redirect_to notfound_path
        end
      end
    end
end
