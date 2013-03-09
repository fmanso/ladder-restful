echo off
set MONGO_URL=mongodb://localhost/elo-tests
mocha --compilers coffee:coffee-script
pause
