module ApplicationHelper
  def bootstrap_class_for flash_type
    classes = { :alert => 'warining', :notice => 'info', :error => 'danger', :success => 'success' }
    classes[flash_type] || 'info'
  end
end
