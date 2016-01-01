ActiveAdmin.register User do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
  permit_params do
    permitted = [:seat, :point, :password, :password_confirmation, :game_id]
  end

  form do |f|
    f.inputs "User" do
      f.input :game_id
      f.input :seat
      f.input :point
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end


end
