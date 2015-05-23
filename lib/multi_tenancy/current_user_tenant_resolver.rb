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
        tenant_id = current_user.send(Rails.application.config.tenant_column.to_sym)

        if tenant_id.present? && Rails.application.config.tenant_class.send(:exists?, tenant_id)
          return Rails.application.config.tenant_class.send(:find, tenant_id)
        end

        return nil
      end
    end
  end
end

ActionController::Base.send :include, MultiTenancy::CurrentUserTenantResolver
