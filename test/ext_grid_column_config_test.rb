require 'test_helper'

def column_config
  [{:dataIndex => 'columnA'},{:dataIndex => 'columnB', :editor => true},{:dataIndex => 'columnC'}]
end

class TestModel < ActiveRecord::Base
  include ExtGridColumnConfig

  ext_grid_columns column_config
end


class ExtGridColumnConfigTest < ActiveSupport::TestCase
  def test_storage_and_retrieval
    assert_equal column_config, TestModel.ext_grid_column_config
  end

  def test_only_filter
    only_a = TestModel.ext_grid_column_config(:only => [:columnA])
    only_ab = TestModel.ext_grid_column_config(:only => [:columnA, :columnB])
    assert_equal 1, only_a.length
    assert_equal 2, only_ab.length
  end

  def test_except_filter
    except_a = TestModel.ext_grid_column_config(:except => [:columnA])
    except_ab = TestModel.ext_grid_column_config(:except => [:columnA, :columnB])
    assert_equal 2, except_a.length
    assert_equal 1, except_ab.length
  end
  
end
