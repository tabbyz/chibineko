class TestcasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_testcase, only: [:update]

   def update
    test = Test.find_by(slug: params[:test_slug])
    if @testcase.update(testcase_params)
      render json: @testcase, status: 200
    else
      render json: @testcase.errors, status: :unprocessable_entity, notice: "Unknown error"
    end
  end

  private
    def set_testcase
      test = Test.find_by(slug: params[:test_slug])
      if test.testcases.exists?(id: params[:id])
        @testcase = test.testcases.find(params[:id])
      else
        render json: nil, status: :unprocessable_entity, notice: "Unknown error"
      end
    end

    def testcase_params
      params.require(:testcase).permit(:result, :note)
    end
end
