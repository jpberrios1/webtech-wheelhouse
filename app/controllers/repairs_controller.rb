class RepairsController < ApplicationController
  before_action :set_repair, only: %i[edit update destroy remove_photo]

  def index
    authorize Repair
    @repairs = policy_scope(Repair)
               .includes(:mechanic, taken_in_by: :employee, bike: %i[customer bike_model])
               .with_attached_intake_photos
               .with_rich_text_diagnosis
               .newest_first
  end

  def show
    @repair = Repair.includes(:mechanic, bike: %i[customer bike_model], repair_services: :standard_service)
                    .with_attached_intake_photos
                    .with_rich_text_diagnosis
                    .find(params[:id])
    authorize @repair
  end

  def new
    @repair = Repair.new(bike_id: params[:bike_id])
    authorize @repair
    3.times { @repair.repair_services.build }
  end

  def edit
    authorize @repair
    @repair.repair_services.build
  end

  def create
    @repair = Repair.new
    authorize @repair

    @repair.assign_attributes(permitted_attributes(@repair))
    @repair.taken_in_by = Current.user

    if @repair.save
      redirect_to @repair, notice: "Repair for bike #{@repair.bike.serial_number} was successfully created."
    else
      @repair.intake_photos = []
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @repair

    attributes = permitted_attributes(@repair)
    new_photos = attributes.delete(:intake_photos)

    @repair.assign_attributes(attributes)

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
    authorize @repair

    if @repair.destroy
      redirect_to repairs_path, notice: "Repair for bike #{@repair.bike.serial_number} was successfully deleted", status: :see_other
    else
      redirect_to @repair, alert: @repair.errors.full_messages.to_sentence
    end
  end

  def remove_photo
    authorize @repair

    photo = @repair.intake_photos.find(params[:photo_id])
    photo.purge
    redirect_back fallback_location: @repair, notice: "The photo was successfully removed.", status: :see_other
  end

  private

  def set_repair
    @repair = Repair.find(params[:id])
  end
end