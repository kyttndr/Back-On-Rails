class UserReviewsController < ApplicationController

    before_action :set_user
    before_action :set_reviewee

    def index
    end

    def new
        @user_review = UserReview.new
    end

    def create
        @user_review = UserReview.new
        @user_review.user = @user
        @user_review.reviewee = @reviewee
        @user_review.rating = params[:user_review][:rating]
        @user_review.comment = params[:user_review][:comment]

        isSaved = @user_review.save
        if isSaved
            flash[:notice] = "You have submitted your review"
            redirect_to user_path(@reviewee)
        else
            flash[:alert] = "Invalid Form!"
            render :new
        end
    end

    def show
    end

    def edit
        @user_review = UserReview.find(params[:id])
    end

    def update
        @user_review = UserReview.find(params[:id])
        @user_review.assign_attributes(request_params)

        #Used to skip duplicate review validation
        if(params[:user_review][:is_edit]=='1')
            @user_review.edit_review = true
        end

        isSaved = @user_review.save
        if isSaved
            flash[:notice] = "You have editted your review"
            redirect_to user_user_reviews_path(@reviewee)
        else
            flash[:alert] = "Invalid Form!"
            render :edit
        end
    end

    def destroy
        @user_review = UserReview.find(params[:id])
        @user_review.destroy
        flash[:notice] = "Deleted Review"
        redirect_to user_user_reviews_path(@reviewee)
    end

    private

        def request_params
            params.require(:user_review).permit(:user,
                                                :reviewee,
                                                :rating,
                                                :comment)
        end

        def set_user
            @user = current_user
        end

        def set_reviewee
            @reviewee = User.find(params[:user_id])
        end

end
