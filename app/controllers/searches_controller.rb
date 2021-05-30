class SearchesController < ApplicationController

    def show
        @search = Search.find(params[:id])
        @airports = @search.airports["Places"]
    end

    def new
        @search = Search.new
    end

    def create
        @search = Search.new(search_params)
        respond_to do |format|
            if @search.save
                format.html { redirect_to @search }
            else
                format.html { render :new }
            end
        end
    end

    private

    def search_params
        params.require(:search).permit(:query, :country, :currency, :locale)
    end

end