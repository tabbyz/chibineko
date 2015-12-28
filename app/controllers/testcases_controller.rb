class TestcasesController < ApplicationController
  before_action :set_testcase, only: [:update]

  def update
    if @testcase.update(testcase_params)
      render json: @testcase, status: 200
    else
      render json: @testcase.errors, status: :unprocessable_entity
    end
  end

  private
    def set_testcase
      test = Test.find_by(slug: params[:test_slug])
      @testcase = test.testcases.find_by(case_id: params[:case_id])
    end

    def testcase_params
      params.require(:testcase).permit(:result, :note)
    end
end
