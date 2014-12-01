class AgilePoi < ActiveRecord::Base
  def age
    t = (Time.now - self.created_at) / 3600
    (1 / (t + 0.01)) / 100
  end
end
