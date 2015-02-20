class Aura < ActiveRecord::Base
  include Statesman::Adapters::ActiveRecordQueries
  has_many :aura_transitions

  def state_machine
    @state_machine ||= AuraStateMachine.new(self, transition_class: AuraTransition)
  end

  validates_presence_of :name, :start_date, :end_date
  validates_uniqueness_of :name

  belongs_to :job_number, inverse_of: :auras
  belongs_to :customer, inverse_of: :auras

  def customer_name
    customer.name
  end

  private

  def self.transition_class
    AuraTransition
  end

  def self.initial_state
    :pending
  end
end
