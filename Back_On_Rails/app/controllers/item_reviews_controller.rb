class ItemReviewsController < ApplicationController

    def index
        @item = Item.find(params[:item_id])
    end

    def new
        @item_review = ItemReview.new
        @item = Item.find(params[:item_id])
    end

    def create
        @item = Item.find(params[:item_id])

        @item_review = ItemReview.new
        @item_review.user = current_user
        @item_review.item = @item
        @item_review.rating = params[:item_review][:rating]
        @item_review.comment = params[:item_review][:comment]

        isSaved = @item_review.save
        if isSaved
            flash[:notice] = "You have submitted your review"
            redirect_to item_path(@item)
        else
            flash[:alert] = "Invalid Form!"
            render :new
        end
    end

    def show
    end

    def edit
    end

    def update
    end

    def destroy
    end

end
