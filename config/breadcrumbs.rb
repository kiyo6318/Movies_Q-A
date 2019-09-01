crumb :root do
  link "Top", root_path
end

crumb :users do
  link "ユーザー一覧",users_path
end

crumb :new_user do
  link "新規ユーザー登録",new_user_path
end

crumb :show_user do |user|
  link "#{user.name}",user_path(user)
  parent :users
end

crumb :edit_user do |user|
  link "アカウント情報編集",edit_user_path(user)
  parent :users
  parent :show_user,user
end

crumb :relations_user do |user|
  link "#{user.name}のつながり",relations_user_path(user)
  parent :users
  parent :show_user,user
end

crumb :new_question do
  link "新規質問",new_question_path
end

crumb :show_question do |question|
  link "質問No.#{question.id}",question_path(question)
end

crumb :edit_question do |question|
  link "質問No.#{question.id}編集",edit_question_path(question)
  parent :show_question,question
end

crumb :new_session do
  link "ログイン",new_session_path
end
# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).