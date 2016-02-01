module RemindMePlease
  module Hooks
    class ViewsLayoutsHook < Redmine::Hook::ViewListener
      def view_layouts_base_html_head(context={})
        javascript_include_tag('multiple-select/multiple-select.js', :plugin => 'redmine_remind_me_please') +
            stylesheet_link_tag('multiple-select/multiple-select.css', :plugin => 'redmine_remind_me_please')
      end
    end
  end
end