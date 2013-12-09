class RegistrationsController < Devise::RegistrationsController

    # alias :super_create :create

    def new
        super
    end

    def create
        # add custom create logic here
        type = "member"
        if params[:is_project_manager] == "on"
            type = "manager"
        end
        params[:type] = type
        super
    end

    def update
        type = "member"
        if params[:is_project_manager] == "on"
            type = "manager"
        end
        params[:type] = type
        super
    end
end
