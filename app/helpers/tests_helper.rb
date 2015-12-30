module TestsHelper
  def current_test
    Test.find_by(slug: params[:slug])
  end
end
