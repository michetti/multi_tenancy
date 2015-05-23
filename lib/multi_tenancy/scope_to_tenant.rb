module MultiTenancy
  module ScopeToTenant
    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods
      def scope_to_tenant(options = {})
        default_scope do
          if MultiTenancy::Tenant.current_id.present?
            # tenant column name to use
            tenant_column = options[:tenant_column] || Rails.application.config.tenant_column

            # scope to tenant
            where(tenant_column => MultiTenancy::Tenant.current_id)
          end
        end
      end
    end
  end
end

ActiveRecord::Base.send :include, MultiTenancy::ScopeToTenant
