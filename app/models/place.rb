class Place < OpenStruct
  def self.rendered_fields
    [:id, :link, :status, :street, :city, :zip, :country, :overall]
  end
end
