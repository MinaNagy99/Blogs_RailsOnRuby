class ArticlesController < ApplicationController
    before_action :authenticate_request!, only: [:create, :update, :destroy, :show, :index]
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action :check_ownership, only: [:update, :destroy]
  
    def index
      @articles = Article.all
    end
  
    def show
    end
  
    def new
      @article = Article.new
      @article.tags.build
    end
  
    def create
      @article = Article.new(article_params)
      @article.created_by = @current_user.id  # Set the created_by field with the user ID from the token
  
      if @article.save
        redirect_to article_path(@article)
      else
        render :new, status: :unprocessable_entity  # Render the new view with the @user object containing errors
      end
    end
  
    def edit
    end
  
    def update
      if @article.update(article_params)
        redirect_to article_path(@article)
          else
            render :edit, status: :unprocessable_entity  # Render the new view with the @user object containing errors
          end
    end
  
    def destroy
      @article.destroy
      redirect_to '/articles'
        end
  
    private
  
    def set_article
      @article = Article.find(params[:id])
    end
  
    def check_ownership
      unless @article.created_by == @current_user.id
        render json: { error: 'You are not authorized to perform this action' }, status: :forbidden
      end
    end
  
    def article_params
      params.require(:article).permit(:title, :body, :status,tag_ids: [],tags_attributes: [:id, :name, :_destroy])
     end
  end
  