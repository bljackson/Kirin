class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]
  
  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.all
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    # Generate breadcrumbs, e.g. Home > Category > Forum > ... > Forum > Topic
    f = Forum.find(@topic.forum_id)
    fs = []

    if f.parent_type == "Forum"

      # Find all forum parents
      while f.parent_type == "Forum"
        f = Forum.find(f.parent_id)
        fs << f
      end

      # Add breadcrumb for Category root
      c = Category.find(f.parent_id)
      add_breadcrumb c.name

      # Add breadcrumbs for Forum leaves
      for f in fs
        add_breadcrumb f.name, "/forums/#{f.id}"
      end
    elsif f.parent_type == "Category"
      add_breadcrumb Category.find(f.parent_id).name, "/categories/#{f.parent_id}"
    end

    add_breadcrumb Forum.find(@topic.forum_id).name, "/forums/#{@topic.forum_id}"
    add_breadcrumb @topic.title, '/'

    # Paginate
    @topic = Topic.find(params[:id])
    @posts = @topic.posts.page(params[:page]).per(2) # 2 for debugging
  end

  # GET /topics/new
  def new
    @topic = Topic.new
    @post = @topic.posts.build
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics
  # POST /topics.json
  def create
    user_id = current_user.id || 1
    @topic = Topic.new(topic_params)
    @topic.user_id = user_id
    @post = @topic.posts.first
    @post.user_id = @topic.user_id
    @post.content = topic_params[:posts_attributes]["0"][:content]

    if @topic.save
      redirect_to "/topics/#{@topic.id}"
    else
      render action: 'new'
    end
  end
  #   respond_to do |format|
  #     if @topic.save
  #       format.html { redirect_to @topic, notice: 'Topic was successfully created.' }
  #       format.json { render :show, status: :created, location: @topic }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @topic.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to @topic, notice: 'Topic was successfully updated.' }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url, notice: 'Topic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit(:title, :description, :forum_id, :user_id, posts_attributes: [:content, :user_id, :topic_id])
    end
end
