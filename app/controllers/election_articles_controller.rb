require 'date'

class ElectionArticlesController < ApplicationController
  def index
    if params.key? :after
      after_date = DateTime.strptime(params[:after], '%s')
      @articles = ElectionArticle.where('datetime(created_at) > :date', date: after_date.to_s(:db))
    else
      @articles = ElectionArticle.all
    end

    puts @articles.length

    render json: @articles, root: nil, scope: get_device_scope
  end

  def show
    @article = ElectionArticle.find(params[:id])

    render json: @article, root: nil, scope: get_device_scope
  end
end
