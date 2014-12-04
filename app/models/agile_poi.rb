class AgilePoi < ActiveRecord::Base
  belongs_to :created_by, class_name: "User", foreign_key: :created_by_user_id
  
  def age
    t = (Time.now - self.created_at) / 3600
    # 1/((x*x*x)/900+0.01)/100 # -> Deutlich flacher
    1/((t*t*t)/100+0.01) / 100 # -> Better curve
    #(1 / (t + 0.01)) / 100 # -> original 1/x
    # Try yourself on: http://www.mathe-fa.de/en#result
  end
end
