require 'test_helper'

class MultiTenancyTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, MultiTenancy
  end
end
