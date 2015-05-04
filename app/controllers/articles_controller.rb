class ArticlesController < ApplicationController
  def index
    if params.key? :after
      after_date = DateTime.strptime((params[:after].to_i + 1).to_s, '%s')
      # @articles = Article.where('created_at > :date OR updated_at > :date', date: after_date)
      @articles = Article.after(after_date)
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
