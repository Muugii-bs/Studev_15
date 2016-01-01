ActiveAdmin.register Quiz do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end
  permit_params do
    permitted = [:content, :op1, :op2, :op3, :op4, :hint, :correct, :closed_at, :odd_id]
  end

  form do |f|
    f.inputs "Quiz" do
      f.input :content
      f.input :op1
      f.input :op2
      f.input :op3
      f.input :op4
      f.input :hint
      f.input :correct
      f.input :closed_at
      f.input :odd_id
    end
    f.actions
  end



end
