class ElectionArticlesController < ApplicationController
  def index
    @articles = ElectionArticle.all

    render json: @articles, root: nil, scope: get_device_scope
  end

  def show
    @article = ElectionArticle.find(params[:id])

    render json: @article, root: nil, scope: get_device_scope
  end
end
