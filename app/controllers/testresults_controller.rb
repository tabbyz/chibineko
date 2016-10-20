class TestresultsController < ApplicationController
  before_action :set_testresult, only: [:update]

   def update
    test = Test.find_by(slug: params[:test_slug])
    if @testresult.update(testresult_params)
      render json: @testresult, status: 200
    else
      render json: @testresult.errors, status: :unprocessable_entity, notice: "Unknown error"
    end
  end

  private
    def set_testresult
      test = Test.find_by(slug: params[:test_slug])
      if test.testresult.exists?(id: params[:id])
        @testresult = test.testresult.find(params[:id])
      else
        render json: nil, status: :unprocessable_entity, notice: "Unknown error"
      end
    end

    def testcase_params
      params.require(:testcase).permit(:result, :note)
    end

end
