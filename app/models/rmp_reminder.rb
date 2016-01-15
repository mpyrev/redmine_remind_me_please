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

  validates :start_date,
            :presence => true,
            :date => true

  validates :interval_type,
            :inclusion => {:in => RmpReminder::INTERVAL_TYPES_LOCALIZED.keys},
            :allow_nil => true,
            :allow_blank => true

  validates :interval_value,
            :numericality => {:only_integer => true, :greater_than => 0},
            :allow_nil => true,
            :if => :interval_type?

  def to_s
    modifier = (interval_unit == INTERVAL_MONTH) ? " #{interval_localized_modifier}" : ""
    schedule = fixed_schedule ? l(:label_recurs_fixed) : l(:label_recurs_dependent)
    "#{l(:label_recurrence_pattern)} #{interval_number} #{interval_localized_name.pluralize(interval_number)}#{modifier}, #{schedule}"
  end
end
