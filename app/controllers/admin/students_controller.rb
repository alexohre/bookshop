class Admin::StudentsController < AdminController
  def new 
    @student = Student.new
  end

  def create 
    @student = Student.new(student_params)
    if @student.save
      redirect_to admin_students_path, notice: 'Student was successfully created.'
    else
      # redirect_to new_student_path, notice: "Oops, something went wrong please try again!"
      render 'admin/dashboard/new_student', status: :unprocessable_entity
    end
  end

  def import
    if params[:file].present?
      Student.import(params[:file])
      redirect_to admin_students_path, notice: "Students imported."
     else
      redirect_to students_path, alert: "Please upload a CSV file."
    end
  end

  private

  def student_params
    params.require(:student).permit(:first_name, :last_name, :other_name, :mat_no, :email, :department, :course, :level)
  end
end