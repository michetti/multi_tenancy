module MultiTenancy::ScopeToTenantFilter
  extend ActiveSupport::Concern

  included do
  end

  module ClassMethods
    def scope_requests_to_current_tenant
      around_filter :scope_request_to_current_tenant

      include MultiTenancy::ScopeToTenantFilter::LocalInstanceMethods
    end
  end

  module LocalInstanceMethods
    def scope_request_to_current_tenant
      tenant = current_tenant
      MultiTenancy::Tenant.current_id = tenant.present? ? tenant.id : nil

      # if a user is signed in, check if he has access to this tenant
      if current_user.present?
        if current_user_tenant_id != tenant.id
          render file: "public/401", status: :unauthorized
          return
        end
      end

      yield
    ensure
      MultiTenancy::Tenant.current_id = nil
    end

    def current_user_tenant_id
      Tenant.current_user_tenant_id
    end
  end
end

ActionController::Base.send :include, MultiTenancy::ScopeToTenantFilter
