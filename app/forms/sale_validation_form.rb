class SaleValidationForm
  include ActiveModel::Model

  def initialize(sale)
    @sale = sale
    form_klass.new(sale)
  end

  def form_klass
    @form_klass ||= "sale_validations::#{sale.status}".camelize.constantize
  end

  private

  attr_reader :sale
end
