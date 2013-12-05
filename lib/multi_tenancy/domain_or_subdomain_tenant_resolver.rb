module MultiTenancy::DomainOrSubdomainTenantResolver
  extend ActiveSupport::Concern

  included do
  end

  module ClassMethods
    def resolve_tenant_by_domain_or_subdomain
      helper_method :current_tenant

      include MultiTenancy::DomainOrSubdomainTenantResolver::LocalInstanceMethods
    end
  end

  module LocalInstanceMethods
    def current_tenant
      @current_tenant ||= find_by_domain(request.host)
      @current_tenant ||= find_by_subdomain(request.subdomains.first)
    end

    def find_by_domain(domain)
      Tenant.find_by_domain(domain)
    end

    def find_by_subdomain!(subdomain)
      Tenant.find_by_subdomain!(subdomain)
    end
  end
end

ActionController::Base.send :include, MultiTenancy::DomainOrSubdomainTenantResolver
