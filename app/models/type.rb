class Type < ApplicationRecord
    validates :name , presence: true
    validate :point_factor_must_be_float_with_one_decimal
    attribute :point_factor, :float, default: 1.0

    private

    def point_factor_must_be_float_with_one_decimal
        if point_factor.nil?
          errors.add(:point_factor, "not empty")
        elsif point_factor.to_f != point_factor || (point_factor * 10) % 1 != 0
          errors.add(:point_factor, "must be float with one decimal")
        end
    end
end
