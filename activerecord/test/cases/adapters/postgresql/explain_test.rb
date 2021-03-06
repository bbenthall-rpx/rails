require "cases/helper"
require 'models/developer'

module ActiveRecord
  module ConnectionAdapters
    class PostgreSQLAdapter
      class ExplainTest < ActiveRecord::TestCase
        fixtures :developers

        def test_explain_for_one_query
          explain = Developer.where(:id => 1).explain
          assert_match %(QUERY PLAN), explain
          assert_match %(Index Scan using developers_pkey on developers), explain
        end

        def test_explain_with_eager_loading
          explain = Developer.where(:id => 1).includes(:audit_logs).explain
          assert_match %(QUERY PLAN), explain
          assert_match %(Index Scan using developers_pkey on developers), explain
          assert_match %(Seq Scan on audit_logs), explain
        end
      end
    end
  end
end
