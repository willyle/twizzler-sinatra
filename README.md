clone repository

bundle install

remove .git file

create git repository

   -- git init
   -- git remote add origin https://github.com/user/repo.git
   -- git add .
   -- git commit -m 'initial commit'
   -- git push origin master

heroku create

heroku apps:rename jc-twizzler-sinatra --app secret-sierra-8949

Check .git/config for heroku remote name. Make sure it matches new name.

Push to heroku

   -- git push heroku master

heroku run rake db:migrate

connect to postgres DB using Psequel and import postgres.sql file (Use SSL)


