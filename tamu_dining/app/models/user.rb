class User < ApplicationRecord
    validates :credits, numericality: { only_integer: true, message: "must be a number" }
end
