ActiveAdmin.register Coupon do
  permit_params :code, :value, :active
end
