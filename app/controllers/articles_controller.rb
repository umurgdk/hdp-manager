class ArticlesController < ApplicationController
  def index
    @articles = Article.all

    render json: @articles, root: nil, scope: get_device_scope
  end

  def show
    @article = Article.find(params[:id])

    render json: @article, root: nil, scope: get_device_scope
  end

  def create

  end
end
