ActiveAdmin.register Project do
  index do
    column :title do |project|
      link_to project.title, admin_project_path(project)
    end
    
    default_actions
  end
  
  # Filter only by title
  filter :title
  
  show :title => :title do # Customize the title of the page
    panel "Tasks" do
      table_for project.tasks do |t|
        t.column("Status") { |task| status_tag (task.is_done ? "Done" : "Pending"), (task.is_done ? :ok : :error) }
        t.column("Title") { |task| link_to task.title, admin_task_path(task) }
        t.column("Assigned To") { |task| task.admin_user.email }
        t.column("Due Date") { |task| task.due_date? ? l(task.due_date, :format => :long) : '-' }
      end
    end
  end
end
