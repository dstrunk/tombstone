class Aura < ActiveRecord::Base
  include Statesman::Adapters::ActiveRecordQueries
  has_many :aura_transitions
  belongs_to :job_number, inverse_of: :auras
  belongs_to :customer, inverse_of: :auras

  validates_presence_of :name, :start_date, :end_date
  validates_uniqueness_of :name

  def state_machine
    @state_machine ||= AuraStateMachine.new(self, transition_class: AuraTransition)
  end

  def customer_name
    customer.name
  end

  scope :unstarted, -> { self.in_state(:unstarted) }
  scope :rejected,  -> { self.in_state(:rejected)  }
  scope :accepted,  -> { self.in_state(:accepted)  }
  scope :live,      -> { self.in_state(:live)      }
  scope :archived,  -> { self.in_state(:archived)  }

  def unstarted
    state_machine.current_state == "unstarted"
  end

  def rejected
    state_machine.current_state == "rejected"
  end

  def accepted
    state_machine.current_state == "accepted"
  end

  def live
    state_machine.current_state == "live"
  end

  def archived
    state_machine.current_state == "archived"
  end

  private

  def self.transition_class
    AuraTransition
  end

  def self.initial_state
    :unstarted
  end
end
