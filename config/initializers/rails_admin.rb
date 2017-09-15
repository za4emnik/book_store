require 'rails_admin/support/i18n'

module RailsAdmin
  module ApplicationHelper
    include RailsAdmin::Support::I18n

    def static_navigation
      li_stack = RailsAdmin::Config.navigation_static_links.collect do |title, url|
        content_tag(:li, link_to(title.to_s, url))
      end.join

      label = RailsAdmin::Config.navigation_static_label || t('admin.misc.navigation_static_label')
      li_stack = %(<li class='dropdown-header'>#{label}</li>#{li_stack}).html_safe if li_stack.present?
      li_stack
    end
  end
end

require_all 'lib/rails_admin'
RailsAdmin.config do |config|
  include ApplicationHelper
  config.parent_controller = 'ApplicationController'

  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  config.authorize_with :cancan

  config.navigation_static_links = {
    'Orders': '/admin/order/in_progress_tab',
    'Reviews': '/admin/review/new_tab_review'
  }

  config.included_models = ['Book', 'Author', 'Category', 'Order', 'Review']

  config.actions do

    state
    change_state
    in_progress_tab
    delivered_tab
    cancelled_tab

    change_to_approved
    change_to_rejected
    new_tab_review
    process_tab_review

    #index do
    #  except [Order, Review]
    #end

    new do
      except [Order, Review]
    end

    dropzone do
      only Book
    end

    index
    dashboard
    bulk_delete
    show
    edit
    delete
  end

  config.model Book do

    field :title
    field :category
    field :authors
    field :materials
    field :year
    field :dimensions
    field :price
    field :description

    configure :authors, :has_many_association
    configure :category, :belongs_to_association
    configure :materials, :has_many_association
    configure :description, :ck_editor

    configure :authors do
      pretty_value do
        value.collect(&:full_name).join(',')
      end
    end

    configure :description do
      pretty_value do
        binding.pry
      end
    end

    list do
      exclude_fields :materials, :year, :dimensions

      field :pictures do
        pretty_value do
          bindings[:view].tag(:img, { :src => bindings[:object].pictures.first.image.url(:thumb) }) unless bindings[:object].pictures.first.blank?
        end
      end

      field :description do
        pretty_value do
          bindings[:object].markdown(value.truncate(50))
        end
      end
    end

    create do
      field :materials
      field :description
      field :authors do
        render do
          bindings[:view].render partial: 'multiple_select', locals: { field: self, form: bindings[:form], method: :full_name }
        end
      end
    end

    edit do
      include_all_fields
      exclude_fields :reviews, :order_items, :pictures

      field :authors do
        render do
          bindings[:view].render partial: 'multiple_select', locals: { field: self, form: bindings[:form], method: :full_name }
        end
      end
    end

    show do
      include_all_fields

      field :description do
        pretty_value do
          bindings[:object].markdown(value)
        end
      end

      field :pictures do
        pretty_value do
          bindings[:view].render partial: 'images_gallery', locals: { value: value }
        end
      end
    end
  end

  config.model Author do

    field :first_name
    field :last_name
    field :description

  end

  config.model Category do

    field :name

  end

  config.model Order do

    field :number
    field :created_at
    field :aasm_state

    visible false

    configure :created_at do
      read_only true
    end

    edit do
      field :number
      field :aasm_state, :state
    end
  end

  config.model Review do
    field :book
    field :created_at
    field :user
    field :aasm_state

    visible false

    configure :created_at do
      read_only true
    end

    configure :book do
      read_only true
    end

    edit do
      exclude_fields :user
      field :message
      field :aasm_state, :state
    end

    show do
      include_fields :message
    end
  end
end
