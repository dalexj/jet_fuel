class LinksController < ApplicationController
  def index
    @link = Link.new
    if sort_query == "created_at"
      @links = Link.sorted_by_created_at
    else
      @links = Link.all
    end
  end

  def show
    link = Link.find_by(local_slug: params[:slug])
    if link
      follow_link link
    else
      redirect_to root_path
    end
  end

  def create
    link = Link.new(link_params)
    flash[:link] = link.local_path if link.save
    redirect_to root_path
  end

  private

  def sort_query
    params[:q]
  end

  def follow_link(link)
    link.update_attributes(visits: link.visits + 1)
    redirect_to link.url
  end

  def link_params
    params.require(:link).permit(:url)
  end
end
