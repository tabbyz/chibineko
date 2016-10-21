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
      if test.testresults.exists?(id: params[:id])
        @testresult = test.testresults.find(params[:id])
      else
        render json: nil, status: :unprocessable_entity, notice: "Unknown error"
      end
    end

    def testresult_params
      params.require(:testresult).permit(:result, :note)
    end

end
