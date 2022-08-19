class BookmarksController < ApplicationController

  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
  end

  def create
    @list = List.find(params[:list_id])
    @movie = Movie.find(params["bookmark"][:movie_id])
    # @movie = Movie.find(params[:movie_id])
    
    @bookmark = Bookmark.new(bookmark_params)

    @bookmark.list = @list
    @bookmark.movie = @movie

    if @bookmark.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def detroy
    @bookmark.list = @list

    @bookmark = Bookmark.find(params[:id])

    @bookmark.destroy
    redirect_to list_path(@list), status: :see_other
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment)
    # params.require(:bookmark).permit(:comment, :movie_id)
  end

end
