class BooksController < ApplicationController

	def new
		@annu = Annu.new
	end

	def create
		@annu = Annu.create(annu_params)
		if @annu.save
			redirect_to books_path
		else
			render 'new'	
		end
	end

  def edit
  	@annu = Annu.find(params[:id])
	end

	def show
		@annu = Annu.find(params[:id])
	end

	def index
		@annus = Annu.all
	end

	def destroy
		@annu = Annu.find(params[:id])
		if @annu.destroy
			redirect_to books_path
		end	
	end

	def update
		@annu = Annu.find(params[:id])
		if @annu.update(annu_params)
			redirect_to books_path
		else
			render 'edit'
		end
	end

	private

	def annu_params 
		params.require(:annu).permit(:name)
	end

end
