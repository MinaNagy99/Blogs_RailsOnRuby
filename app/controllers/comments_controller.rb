class CommentsController < ApplicationController
  before_action :authenticate_request!, only: [:create, :update, :destroy]
  before_action :set_comment, only: [:destroy, :edit, :update]
  before_action :check_ownership, only: [:destroy, :update]
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.new(comment_params)
    @comment.created_by = @current_user.id  # Set the created_by field with the user ID from the token

    if @comment.save
      redirect_to article_path(@article)
    else
      render 'articles/show', status: :unprocessable_entity
    end
  end

  def edit
  end
  def update
    puts "Update article"
    if @comment.update(comment_params)
      redirect_to article_path(@article)
    else
      render 'articles/show', status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    redirect_to article_path(@article), status: :see_other
  end
  private

  def comment_params
    params.require(:comment).permit( :body, :status)
  end

  def check_ownership
    @comment.created_by == @current_user.id
  end

  def set_comment
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
  end
end
