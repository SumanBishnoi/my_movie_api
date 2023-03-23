class Api::V1::ListsController < ApiController
    before_action :set_list , only: [:show, :update, :destroy]
    
    def index
        @lists = current_user.lists
        render json: @lists, status: :ok

    end

    def show
        render json: @list, status: :ok
    end

    def create
        @list = current_user.lists.new(list_params)
        if @list.save
            render json: @list, status: :ok
        else
            render json: { data: @list.errors.full_messages, status: "failed" }, 
            status: :unprocessable_entity
        end
    end

    def update
        if @list.update(list_params)
            render json: @list, status: :ok
        else
            render json: { data: @list.errors.full_messages, status: "failed" }, 
            status: :unprocessable_entity
        end
    end

    def destroy
        if @list.destroy
            render json: { data: 'List removed', status: 'success'},
            status: :ok
        else
            render json: {data: 'Something went wrong', status: 'failed'}
        end
    end
    

    private 

    def list_params
        params.require(:list).permit(:name, :description)
    end

    def set_list
        @list = current_user.lists.find(params[:id])
    rescue ActiveRecord::RecordNotFound => error
        render json: error.message, status: :unauthorized
    end


end