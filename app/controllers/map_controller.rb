class MapController < ApplicationController
  def map
    respond_to do |format|
      format.js
  end
end
