module Shoulda
  module Matchers
    module ActiveModel
      extend Helpers
      def validate_num_in_range(arg, min, max)
        validator = validate_numericality_of(arg).is_greater_than_or_equal_to(min)
        validator.is_less_than_or_equal_to(max)
      end
    end
  end
end
