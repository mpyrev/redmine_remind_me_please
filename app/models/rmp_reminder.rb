class RmpReminder < ActiveRecord::Base
  unloadable

  belongs_to :issue
  has_one :project, :through => :issue

  INTERVAL_DAY = 'd'
  INTERVAL_WEEK = 'w'
  INTERVAL_MONTH = 'm'
  INTERVAL_YEAR = 'y'

  INTERVAL_TYPES_LOCALIZED = {
    INTERVAL_DAY => l(:interval_day),
    INTERVAL_WEEK => l(:interval_week),
    INTERVAL_MONTH => l(:interval_month),
    INTERVAL_YEAR => l(:interval_year)
  }

  validates :base_date,
            :presence => true,
            :date => true

  validate :base_date_cannot_be_in_the_past, :on => :create

  def base_date_cannot_be_in_the_past
    errors.add(:base_date, l(:error_date_should_be_future)) if !base_date.blank? and base_date <= Date.today
  end

  validates :interval_type,
            :inclusion => {:in => RmpReminder::INTERVAL_TYPES_LOCALIZED.keys},
            :if => :periodic?

  validates :interval_value,
            :numericality => {:only_integer => true, :greater_than => 0},
            :if => :periodic?

  def to_pretty_s
    if periodic
      "#{l(:reminder_repeat_every)} #{interval_value} #{interval_localized_name.pluralize(interval_value)}"
    else
      l(:reminder_not_periodic)
    end
  end

  def interval_localized_name
    if self.new_record?
      @interval_localized_name
    else
      if INTERVAL_TYPES_LOCALIZED.has_key?(interval_type)
        INTERVAL_TYPES_LOCALIZED[interval_type]
      else
        raise "#{l(:error_invalid_interval)} #{interval_type} (interval_localized_name)"
      end
    end
  end

  def self.remind!
    RmpReminder.all.each do |reminder|
      reminder.remind_about_issue_if_needed!
    end
  end

  def remind_about_issue_if_needed!
    today = Date.today
    if notification_date <= today
      issue.init_journal(User.find(1), l(:text_issue_reminder))
      issue.save!

      if periodic
        while notification_date <= today
          case interval_type
            when INTERVAL_DAY
              self.notification_date += interval_value
            when INTERVAL_WEEK
              self.notification_date += interval_value.weeks
            when INTERVAL_MONTH # Our special one
              date1 = base_date
              date2 = notification_date
              delta_months = (date2.year * 12 + date2.month) - (date1.year * 12 + date1.month)
              delta_months = [delta_months, 0].max
              self.notification_date = base_date + (delta_months + interval_value).months
            when INTERVAL_YEAR
              self.notification_date += interval_value.years
            else
              raise "#{l(:error_invalid_interval_type)} #{interval_type}"
          end
        end
        save!
      else
        destroy
      end
    end
  end
end
