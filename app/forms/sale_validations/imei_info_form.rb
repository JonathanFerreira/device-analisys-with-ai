module SaleValidations
  class ImeiInfoForm
    include ActiveModel::Model

    attr_accessor :sale, :imei

    validates :imei, presence: true, format: { with: /\A\d{15}\z/, message: "deve conter 15 dígitos numéricos" }
    validates :sale, presence: true

    def save
      if valid?
        sale.update(imei: imei, status: 'device_front_photo')
      end
    end
  end
end
