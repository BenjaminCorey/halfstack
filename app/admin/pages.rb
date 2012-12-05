ActiveAdmin.register Page do
  controller do
    defaults finder: :find_by_slug!
  end

end
