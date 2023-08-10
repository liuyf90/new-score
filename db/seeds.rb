# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
projects = [
    { name: '绥化城管', amount: 899.99, sponsor: '张三' },
    { name: '鹤岗城管', amount: 899.99, sponsor: '张三' },
    { name: '伊春城管', amount: 899.99, sponsor: '张三' },
    { name: '内蒙城管', amount: 899.99, sponsor: '李四' },
    { name: '哈尔滨城管', amount: 899.99, sponsor: '李四' },
    { name: '漠河城管', amount: 899.99, sponsor: '李四' },
    { name: '大庆城管', amount: 899.99, sponsor: '李四' }
  ]

Project.create!(projects)


staffs = [
    { name: '张三', status: 1, mobile: '18600000000' },
    { name: '李四', status: 0, mobile: '15600000000' }
]
Staff.create!(staffs)
  
  
  
  
  
  

