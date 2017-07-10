class Pin < ApplicationRecord
	belongs_to :pinnable, :polymorphic => true
end
