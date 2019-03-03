module BlocRecord
  class Collection < Array
    def take(num=1)
      self[0..num-1]
    end

    def where(param)
      arr = []
      for val in self
        for k in param.keys
          arr += self.first.class.where("id" => val.id, k => param[k])
        end
      end
      arr
    end

    def not(param)
      arr = []
      for val in self
        for k in param.keys
          arr += self.first.class.where("id" => val.id, k => !param[k])
        end
      end
      arr
    end

    def update_all(updates)
      ids = self.map(&:id)
      self.any? ? self.first.class.update(ids, updates) : false
    end
  end
end
