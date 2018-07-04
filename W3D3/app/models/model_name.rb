class Person < ActiveRecord::Base
  belongs_to :house, {
    primary_key: :id,
    foreign_key: :house_id,
    class_name: 'House'
  }
end

class House < ActiveRecord::Base
  has_many :people, {
    primary_key: :id,
    foreign_key: :person_id,
    class_name: 'Person'
  }

end
