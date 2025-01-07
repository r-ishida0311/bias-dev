# This will truncate the applies table, removing all data.
# Apply.destroy_all #This line is likely unrelated, it's about a different table.

# User.create!(login: 'ep-7777') # Replace 'password' and 'email' with appropriate values.

User.find(2).destroy if User.exists?(2)




