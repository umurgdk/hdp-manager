class ArticlesController < ApplicationController
  def index
    if params.key? :after
      after_date = DateTime.strptime(params[:after], '%s')
      @articles = Article.where('datetime(created_at) > :date', date: after_date.to_s(:db))
    else
      @articles = Article.all
    end

    puts @articles.length

    render json: @articles, root: nil, scope: get_device_scope
  end

  def show
    @article = Article.find(params[:id])

    render json: @article, root: nil, scope: get_device_scope
  end

  def create

  end
end
