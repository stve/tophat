module TopHat
  module HashOnly
    # Returns a new hash with only the given keys.
    def only(*keys)
      reject {|key, value| !keys.include?(key) }
    end
 
    # Replaces the hash without only the given keys.
    def only!(*keys)
      replace(only(*keys))
    end
  end
end
