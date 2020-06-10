class MapController < ApplicationController

  def map
    results = Geocoder.search(params[:address])
    @latlng = results.first.coordinates

    respond_to do |format|
      format.js
    end
  end

end
