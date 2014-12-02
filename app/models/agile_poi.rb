class AgilePoi < ActiveRecord::Base
  def age
    t = (Time.now - self.created_at) / 3600
    # 1/((x*x*x)/900+0.01)/100 # -> Deutlich weniger flach
    1/((t*t*t)/100+0.01) / 100 # -> Better curve
    #(1 / (t + 0.01)) / 100 # -> original 1/x
    # Try yourself on: http://www.mathe-fa.de/en#result
  end
end
