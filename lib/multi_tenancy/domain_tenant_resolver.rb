module MultiTenancy
  module DomainTenantResolver
    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods
      def resolve_tenant_by_domain
        helper_method :current_tenant

        include MultiTenancy::DomainTenantResolver::LocalInstanceMethods
      end
    end

    module LocalInstanceMethods
      def current_tenant
        @current_tenant ||= find_by_domain(request.host)
      end

      def find_by_domain(domain)
        Tenant.find_by_domain(domain)
      end
    end
  end
end

ActionController::Base.send :include, MultiTenancy::DomainTenantResolver
