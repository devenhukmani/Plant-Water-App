const http = require('http')
const fs = require('fs')

const express = require('express');
const app = express();

var currentAppData = "{}"
var currentSensorData = "{}"

const port = 3000
const responseData = {
      message:"Hello, GFG Learner",
    articleData:{
        articleName: "How to send JSON response from NodeJS",
        category:"NodeJS",
        status: "published"
    },
    endingMessage:"Visit Geeksforgeeks.org for more YIPPEE"
  }

app.use(express.json());

app.listen(port, (error) => {
      if(error){
        console.log('Something went wrong', error)
    }else{
        console.log('Server is listening on port ' + port)
    }
});

app.get('/toApp', (req, res) => { //send info when requested from http://IP:PORT/toApp
    res.status(200).send(currentSensorData)
});
app.get('/toSensor', (req, res) => { //send info when requested from http://IP:PORT/toSensor
    res.status(200).send(currentAppData)
});

app.post('/fromApp', (req, res) => {
  const requestData = req.body

  console.log('Received data:', requestData)

  res.status(200).json({ message: 'Data received successfully!', receivedData: requestData})

  currentAppData = requestData
});

app.post('/fromSensor', (req, res) => {
  const requestData = req.body

  console.log('Received data:', requestData)

  res.status(200).json({ message: 'Data received successfully!', receivedData: requestData})
  
  currentSensorData = requestData
});