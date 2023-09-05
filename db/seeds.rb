# This file should contain all the record creation needed to seed the database with its default values.

# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Task.delete_all
Project.delete_all
UsersRole.delete_all
Staff.delete_all
Role.delete_all
User.delete_all
Type.delete_all


users = [
  {
    email: 'liuyf90@gmail.com',password: '123456'
  },
  {
    email: 'zhangsan@gmail.com',password: '123456'
  }
  
]
User.create!(users)

roles = [
  { name: 'admin', description: '管理员' },
  { name: 'user', description: '普通用户' }
]
Role.create!(roles)

users_roles = [
  { user: User.first, role: Role.first },
  { user: User.second, role: Role.second }
]
UsersRole.create!(users_roles)
staffs = [
    { name: '刘宇飞', status: 1, mobile: '18600000000', user: User.first},
    { name: '李四', status: 0, mobile: '18600000000', user: User.second}
]
Staff.create!(staffs)
  
projects = [
  { name: '绥化城管', amount: 899.99, staff: Staff.first },
  { name: '鹤岗城管', amount: 899.99, staff: Staff.first },
  { name: '伊春城管', amount: 899.99, staff: Staff.first },
  { name: '内蒙城管', amount: 899.99, staff: Staff.second },
  { name: '黑龙江城管', amount: 899.99,staff: Staff.second }, 
  { name: '漠河城管', amount: 899.99, staff: Staff.second },
  { name: '大庆城管', amount: 899.99, staff: Staff.second }
]

Project.create!(projects) 
  
  
tasks = [
  { name: '设计原型', descript: '绥化城管', status: 1, project: Project.first, user: User.first },
  { name: '原型建模', descript: '绥化城管', status: 1, project: Project.first, user: User.first },
  { name: '开发', descript: '绥化城管', status: 1, project: Project.first, user: User.second },
  { name: '测试', descript: '绥化城管', status: 1, project: Project.first, user: User.second}
] 
Task.create!(tasks)
  

types = [
  { name: '设计', point_factor: 1.0 },
  { name: '开发', point_factor: 1.2 },
  { name: '测试', point_factor: 1.5 },
  { name: '运维', point_factor: 1.8 }
]
Type.create!(types)