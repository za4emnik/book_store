module UsersHelper
  def active_tab
    '#privacy' unless (params.keys & %w[email_form password_form]).empty?
  end
end
