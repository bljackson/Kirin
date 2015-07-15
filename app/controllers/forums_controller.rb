class ForumsController < ApplicationController
  before_action :set_forum, only: [:show, :edit, :update, :destroy]

  # GET /forums
  # GET /forums.json
  def index
    @categories = Category.by_position
  end

  # GET /forums/1
  # GET /forums/1.json
  def show
    f = @forum
    fs = []

    @topics = f.topics.page(params[:page]).per(2) # 2 for debugging

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

    elsif @forum.parent_type == "Category"
      add_breadcrumb Category.find(@forum.parent_id).name, "/categories/#{@forum.parent_id}"
    end
    add_breadcrumb @forum.name, "/forums/#{@forum.id}"
  end

  # GET /forums/new
  def new
    @forum = Forum.new
  end

  # GET /forums/1/edit
  def edit
  end

  # POST /forums
  # POST /forums.json
  def create
    @forum = Forum.new(forum_params)

    respond_to do |format|
      if @forum.save
        format.html { redirect_to @forum, notice: 'Forum was successfully created.' }
        format.json { render :show, status: :created, location: @forum }
      else
        format.html { render :new }
        format.json { render json: @forum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /forums/1
  # PATCH/PUT /forums/1.json
  def update
    respond_to do |format|
      if @forum.update(forum_params)
        format.html { redirect_to @forum, notice: 'Forum was successfully updated.' }
        format.json { render :show, status: :ok, location: @forum }
      else
        format.html { render :edit }
        format.json { render json: @forum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forums/1
  # DELETE /forums/1.json
  def destroy
    @forum.destroy
    respond_to do |format|
      format.html { redirect_to forums_url, notice: 'Forum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_forum
      @forum = Forum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def forum_params
      params.require(:forum).permit(:name, :description, :position, :category_id)
    end
end
