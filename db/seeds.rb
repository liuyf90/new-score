# This file should contain all the record creation needed to seed the database with its default values.

# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


users = [
  {
    email: 'liuyf90@gmail.com',password: '123456'
  },
  {
    email: 'zhangsan@gmail.com',password: '123456'
  }
  
]
User.create!(users)




staffs = [
    { name: '张三', status: 1, mobile: '18600000000', user: User.first},
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
  
  
  
  

