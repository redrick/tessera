module Tessera
  module Otrs
    class Base
      def to_hash
        Hash[instance_variables.map do |v|
          [v.to_s[1..-1].to_sym, instance_variable_get(v)]
        end]
      end
    end
  end
end
