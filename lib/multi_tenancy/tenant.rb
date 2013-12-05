module MultiTenancy::Tenant
  extend ActiveSupport::Concern

  included do
  end

  module ClassMethods
    def acts_as_tenant(options = {})
      has_many :users, dependent: :destroy
      accepts_nested_attributes_for :users

      validates :name, :subdomain,
                presence: true, uniqueness: true

      validates :domain,
                uniqueness: true

      validates_associated :users
      validates_presence_of :users, on: :save

      include MultiTenancy::Tenant::LocalInstanceMethods
    end
  end

  module LocalInstanceMethods
    def to_s
      subdomain || domain
    end
  end

  def self.tenant_class
    Rails.application.config.tenant_class
  end

  def self.tenant_column
    Rails.application.config.tenant_column
  end

  def self.current_id=(id)
    Thread.current[Rails.application.config.tenant_column] = id
  end

  def self.current_id
    Thread.current[Rails.application.config.tenant_column]
  end

  def self.current
    self.tenant_class.find_by_id(self.current_id)
  end

  def self.find_by_id(id)
    self.tenant_class.find_by_id(id)
  end

  def self.find_by_id!(id)
    self.tenant_class.find_by_id(id)
  end

  def self.find_by_domain(domain)
    self.tenant_class.find_by_domain(domain)
  end
end
 
ActiveRecord::Base.send :include, MultiTenancy::Tenant