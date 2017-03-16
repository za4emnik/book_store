ActiveAdmin.register Review do

  permit_params :title, :score, :message, :book, :published

end
