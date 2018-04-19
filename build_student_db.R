# From BASH:
# follow instructions from 
# https://support.rackspace.com/how-to/installing-mysql-server-on-ubuntu/
# No password set
# Run MySQL: sudo /usr/bin/mysql -u root -p
# 
# From MySQL:
# MAKE DB smarter;
# CREATE USER 'school_admin'@'localhost' IDENTIFIED BY '';
# GRANT ALL PRIVILEGES ON smarter.* TO 'school_admin'@'localhost';
#
# From R:
# install.packages("RMySQL")
# Worked past a few errors here also, including one involving MariaDB

library(RMySQL)

class_data <- data.frame(
  Student = c("Andile", "Andile", "Bongani", "Bongani", "Charlie"),
  Teacher = c("Brendan", "David", "Brendan", "David", "Brendan"),
  Grade = rep(0,5),
  Comment = rep("", 5))

con <- dbConnect(MySQL(),
                 user = "school_admin",
                 password = "",
                 host = "127.0.0.1", # "localhost", #"127.0.0.1",
                 dbname = "smarter")

summary(con)
dbGetInfo(con)
dbListTables(con)
dbWriteTable(con, "class_data", class_data)


res = dbSendQuery(con, "SELECT * FROM class_data
                  WHERE Teacher = 'David';")
data = dbFetch(res)
data$Comment[data$Student=="Andile"] = "Good Progress"

