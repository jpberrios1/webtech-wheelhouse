class RepairsController < ApplicationController

    before_action :set_repair, only: %i[edit update destroy remove_photo]

    def index
        @repairs = Repair.includes(:mechanic, bike: [:customer, :bike_model]).with_attached_intake_photos.with_rich_text_diagnosis.newest_first
    end

    def show
        @repair = Repair.includes(:mechanic, bike: [:customer, :bike_model], repair_services: :standard_service)
                        .with_attached_intake_photos
                        .with_rich_text_diagnosis
                        .find(params[:id])
    end

    def new
        @repair = Repair.new(bike_id: params[:bike_id])
        3.times { @repair.repair_services.build }
    end

    def edit
    end

    def create
        @repair = Repair.new(repair_params)

        if @repair.save
            redirect_to @repair, notice: "Repair for bike #{@repair.bike.serial_number} was successfully created."
        else
            @repair.intake_photos = []
            render :new, status: :unprocessable_entity
        end
    end

    def update
        new_photos = params[:repair].delete(:intake_photos)

        @repair.assign_attributes(repair_params)

        original_photos = @repair.intake_photos.map(&:blob)

        @repair.intake_photos.attach(new_photos) if new_photos.present?

        if @repair.save
            redirect_to @repair, notice: "Repair for bike #{@repair.bike.serial_number} was successfully updated."
        else
            @repair.intake_photos = original_photos
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        if @repair.destroy
            redirect_to repairs_path, notice: "Repair for bike #{@repair.bike.serial_number} was successfully deleted", status: :see_other
        else
            redirect_to @repair, alert: @repair.errors.full_messages.to_sentence
        end
    end

    def remove_photo
        photo = ActiveStorage::Attachment.find(params[:photo_id])
        photo.purge
        redirect_back fallback_location: @repair, notice: "The photo was successfully removed.", status: :see_other
    end


    private

    def set_repair
        @repair = Repair.find(params[:id])
    end

    def repair_params
        params.require(:repair).permit(:bike_id, :mechanic_id, :state, :is_approved, :promised_on, :handed_back_at,
         :diagnosis, intake_photos: [], repair_services_attributes: [:id, :standard_service_id, :charged_price, :_destroy])
    end

end