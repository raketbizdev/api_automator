#! /bin/sh
# Description: Create a Express Automation

echo "Create A Package"

npm init
echo "package.json is created"
echo "..."
echo "Install Dependency"
echo "Installing Express"

npm i express mongoose
echo "installing dotenv and nodemon"
npm i --save-dev dotenv nodemon
mkdir models
mkdir routes
mkdir controllers
mkdir controllers
touch server.js
touch .env
touch .env.example
touch .gitignore

touch routes/subscribers.js

echo "$(jq '.scripts += {"devStart":"nodemon server.js"}' package.json)" > package.json

cat << EOF >> .gitignore
.env
node_modules
EOF

cat << EOF >> server.js
require('dotenv').config()
const express = require('express')
const { default: mongoose } = require('mongoose')
const app = express()

// Connnect to DB
mongoose.connect(process.env.DATABASE_URL, {useNewUrlParser: true})
const db = mongoose.connection
db.on('error',(error) => console.error(error))
db.once('open', () => console.log('Connected to DB'))

// output json object
app.use(express.json())

// create routes subscriber
const subscribersRouter = require('./routes/subscriber')
app.use('/subscriber', subscribersRouter)

// Check server in terminal if running
app.listen(3000, () => console.log('Server Started'))
EOF

cat << EOF >> .env
DATABASE_URL=mongodb://localhost/subscribers
EOF
cat << EOF >> .env.example
DATABASE_URL=$mongoDBURL
EOF


cat << EOF >> routes/subscribers.js
const express = require('express')
const routes = express.Router()

module.exports = Router
EOF
