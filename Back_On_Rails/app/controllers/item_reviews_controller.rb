class ItemReviewsController < ApplicationController

    before_action :set_user
    before_action :set_item

    def index
    end

    def new
        @item_review = ItemReview.new
    end

    def create
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
        @item_review = ItemReview.find(params[:id])
    end

    def update
        @item_review = ItemReview.find(params[:id])
        @item_review.assign_attributes(request_params)
        isSaved = @item_review.save
        if isSaved
            flash[:notice] = "You have editted your review"
            redirect_to item_item_reviews_path(@item)
        else
            flash[:alert] = "Invalid Form!"
            render :edit
        end
    end

    def destroy
        @item_review = ItemReview.find(params[:id])
        @item_review.destroy
        flash[:notice] = "Deleted Review"
        redirect_to item_item_reviews_path(@item)
    end

    private
        def request_params
            params.require(:item_review).permit(:user,
                                                :item,
                                                :rating,
                                                :comment)
        end

        def set_user
            @user = current_user
        end

        def set_item
            @item = Item.find(params[:item_id])
        end

end
