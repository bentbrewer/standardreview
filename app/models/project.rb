class Project < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name         :string
    date         :date, :required
    phone        :string, :required
    organization :string, :required
    email        :email_address, :required
    address      :string, :required
    city         :string, :required
    zip          :string, :required
    com_rec      enum_string(:"new text", :"revised text", :"deleted text") 
    comment      :html, :required
    support      :html, :required
    signature    :string, :required
    rop_email    :email_address
    timestamps
  end

  belongs_to :state
  belongs_to :standard
  belongs_to :area

  #after_create do |project|
  #  ProjectMailer.standard_comment(id, name, date, phone, organization, email, address, city, state, zip, standard,
  #                                    standard_area, com_rec, comment, support, rop_email).deliver
  #end

  # --- Permissions --- #

  def create_permitted?
    true
  end

  def update_permitted?
    acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end

end
