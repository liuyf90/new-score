class TypeController < ApplicationController
    def index
        @types = Type.page(params[:page]).per(5)
    end
end
