class GeneralController < ApplicationController

    def index
        render "general/index", layout: false
    end
end
