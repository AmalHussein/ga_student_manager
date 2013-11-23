class CreateOneOnOnes < ActiveRecord::Migration
  def change
    create_table :one_on_ones do |t|
      t.belongs_to :student, index: true
      t.belongs_to :teacher, index: true
      t.datetime :date
      t.text :notes
      t.text :student_concerns
      t.text :teacher_concerns
    end
  end
end
