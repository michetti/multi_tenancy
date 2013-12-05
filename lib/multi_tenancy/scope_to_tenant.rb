module MultiTenancy::ScopeToTenant
  extend ActiveSupport::Concern

  included do
  end

  module ClassMethods
    def scope_to_tenant(options = {})
      default_scope do
        if MultiTenancy::Tenant.current_id.present?
          where(Rails.application.config.tenant_column => MultiTenancy::Tenant.current_id)
        end
      end
    end
  end
end

ActiveRecord::Base.send :include, MultiTenancy::ScopeToTenant
