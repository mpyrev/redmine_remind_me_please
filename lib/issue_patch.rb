module IssuePatch
  def self.included(base)
    base.class_eval do
      has_many :rmp_reminders, :foreign_key => 'issue_id', :dependent => :delete_all # cascading delete

      def reminds?
        !(rmp_reminders.nil? || rmp_reminders.length <= 0)
      end
    end # base.class_eval
  end # self.included
end # issues patch