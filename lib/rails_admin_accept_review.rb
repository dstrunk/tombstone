require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

module RailsAdmin
  module Config
    module Actions
      class AcceptReview < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :member do
          true
        end

        register_instance_option :visible? do
          bindings[:object].class == Aura &&
          bindings[:object].unstarted
        end

        register_instance_option :link_icon do
          'icon-check'
        end

        register_instance_option :controller do
          Proc.new do
            @object.state_machine.transition_to(:accepted)
            flash[:success] = "You have accepted aura #{@object.name}."
            
            redirect_to back_or_index
          end
        end
      end
    end
  end
end
