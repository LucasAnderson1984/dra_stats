module SimpleCRUD
  extend ActiveSupport::Concern

  def index
    render_index
  end

  def show
    render_show
  end

  def new
    render_new
  end

  def create
    redirect_to(resource, notice: t('.success')) and return if resource.save

    flash[:alert] = t('.failure')
    render_new
  end

  def edit
    render_edit
  end

  def update
    redirect_to(resource, notice: t('.success')) and return \
      if resource.update_attributes(resource_params)

    flash[:alert] = t('.failure')
    render_edit
  end

  def destroy
    redirect_to(resource, notice: t('.success')) and return \
      if resource.destroy

    flash[:alert] = t('.failure')
    render_index
  end

  private

  def render_index
    render :index, locals: { resources: resources }
  end

  def render_show
    render :show, locals: { resource: resource }
  end

  def render_new
    render :new, locals: { resource: resource }
  end

  def render_edit
    render :edit, locals: { resource: resource }
  end

  def resource
    @resource ||= params[:id] ? find_resource : build_resource
  end

  def resources
    @resources ||= search.result
  end

  def build_resource
    resource_class.new(resource_params)
  end

  def find_resource
    resource_class.find(params[:id])
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
