class BookmarksController < ApplicationController

  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
  end

  def create
    @list = List.find(params[:list_id])
    @movie = Movie.find(params["bookmark"][:movie_id].to_i)
    
    @bookmark = Bookmark.new(bookmark_params)

    @bookmark.list = @list
    @bookmark.movie = @movie

    if @bookmark.save
      redirect_to lists_path # ?????
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment)
  end

end
