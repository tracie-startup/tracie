require 'test_helper'

class AgilePoisControllerTest < ActionController::TestCase
  setup do
    @agile_poi = agile_pois(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:agile_pois)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create agile_poi" do
    assert_difference('AgilePoi.count') do
      post :create, agile_poi: { created_by: @agile_poi.created_by, decay_rate: @agile_poi.decay_rate, description: @agile_poi.description, latitude: @agile_poi.latitude, longitude: @agile_poi.longitude, posted_by: @agile_poi.posted_by, title: @agile_poi.title }
    end

    assert_redirected_to agile_poi_path(assigns(:agile_poi))
  end

  test "should show agile_poi" do
    get :show, id: @agile_poi
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @agile_poi
    assert_response :success
  end

  test "should update agile_poi" do
    patch :update, id: @agile_poi, agile_poi: { created_by: @agile_poi.created_by, decay_rate: @agile_poi.decay_rate, description: @agile_poi.description, latitude: @agile_poi.latitude, longitude: @agile_poi.longitude, posted_by: @agile_poi.posted_by, title: @agile_poi.title }
    assert_redirected_to agile_poi_path(assigns(:agile_poi))
  end

  test "should destroy agile_poi" do
    assert_difference('AgilePoi.count', -1) do
      delete :destroy, id: @agile_poi
    end

    assert_redirected_to agile_pois_path
  end
end
