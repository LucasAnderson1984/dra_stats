# frozen_string_literal: true

module SimpleCRUD
  extend ActiveSupport::Concern

  def index
    render_index
  end

  def show
    render_show
  end

  def create
    render json: {
      message: I18n.t('teachers.create.success'),
      resource: resource
    }.to_json and return if resource.save

    render status: 422, json: {
      message: I18n.t('teachers.create.failure')
    }
  end

  def update
    render status: 404, json: resource and return \
    unless resource.is_a?(Teacher)

    render json: {
      message: I18n.t('teachers.update.success'),
      resource: resource
    }.to_json and return if resource.update_attributes(resource_params)

    render status: 422, json: {
      message: I18n.t('teachers.update.failure')
    }
  end

  private

  def render_index
    render json: resources
  end

  def render_show
    render status: 404, json: resource and return \
    unless resource.is_a?(Teacher)

    render json: resource
  end

  def resource
    @resource ||= params[:id] ? find_resource : build_resource
  end

  def resources
    @resources ||= resource_class.all
  end

  def build_resource
    resource_class.new(resource_params)
  end

  def find_resource
    resource_class.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    e
  end

  def resource_name
    @resource_name ||= controller_name.singularize
  end

  def resource_class
    @resource_class ||= resource_name.classify.constantize
  end

  def resource_params
    @resource_params ||= send("#{resource_name}_params")
  end
end
