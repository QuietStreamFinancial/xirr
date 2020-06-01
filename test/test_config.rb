require_relative 'test_helper'

describe 'Xirr' do
  it 'has constants for each item in the config' do
    Xirr.config.each do |key, value|
      constant_value = Xirr.const_get(key.to_s.upcase.to_sym)

      if value.nil?
        assert_nil constant_value
      else
        assert_equal value, constant_value
      end
    end
  end

  it 'uses configured values as constants' do
    Xirr.configure do |config|
      config.replace_for_nil = nil
    end

    assert_nil Xirr::REPLACE_FOR_NIL
  end

  it "raises an error if an unconfigured constant is used" do
    assert_raises(NameError) { Xirr::UNDEFINED_CONSTANT }
  end
end
