class WelcomeController < ApplicationController
  def index
    @places = Place.all.select {|p| p.items.count > 0}
    gon.places = @places
    @is_index = true
  end

  def about
  end

  def privacy_policy
  end

  def faq
  end

  def contact_us
  end
end
