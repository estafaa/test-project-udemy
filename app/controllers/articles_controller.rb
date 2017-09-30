class ArticlesController < ApplicationController
    
    before_action :set_article, only: [:edit, :update, :show, :destroy]
    before_action :require_user, except: [:index, :show]
    before_action :require_same_user, only: [:edit, :updat, :destroy]
    
  
  def index
      @articles = Article.paginate(page: params[:page], per_page: 5)
  end
  
    def new
        @article = Article.new
    end
    
    def edit
    end

    def create
    #   render plain: params[:article].inspect 
  #  debugger
        @article = Article.new(article_params)
       @article.user = current_user
      
      if @article.save
          #do smth
          flash[:success] = "Article was succesfully created"
          redirect_to article_path(@article)
      else 
          render 'new'
      end
      
    end
    
    def update
        if @article.update(article_params)
            flash[:success] = "Artcile was updated"
            redirect_to article_path(@article)
        else
            render 'edit'
        end
       
    end
    
    
    def show
    end
    
   
    
    def destroy
    @article.destroy
    flash[:danger] = "Articles ##{@article.id} with Title: ''#{@article.title}'' was deleted"
    redirect_to articles_path
    end

    private
    def set_article
         @article = Article.find(params[:id])
    end
    
    def article_params
    params.require(:article).permit(:title, :description)
    end
    
    def require_same_user
        if current_user != @article.user
            flash[:danger] = "You can edit or delete only your articles"
            redirect_to root_path
        end
    end
    

    
    
end
