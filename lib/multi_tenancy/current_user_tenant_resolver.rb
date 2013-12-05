module MultiTenancy
  module CurrentUserTenantResolver
    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods
      def resolve_tenant_by_current_user
        helper_method :current_tenant

        include MultiTenancy::CurrentUserTenantResolver::LocalInstanceMethods
      end
    end

    module LocalInstanceMethods
      def current_tenant
        @current_tenant ||= find_by_current_user
      end

      def find_by_current_user
        Tenant.find_by_id(current_user.tenant_id) if current_user.present?
      end
    end
  end
end

ActionController::Base.send :include, MultiTenancy::CurrentUserTenantResolver
