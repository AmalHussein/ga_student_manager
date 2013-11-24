class AddCourseIdToOneOnOnes < ActiveRecord::Migration
  def change
    add_reference :one_on_ones, :course, index: true
  end
end
