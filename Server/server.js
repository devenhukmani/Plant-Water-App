const http = require('http')

const express = require('express');
const server = express();

var currentAppData = "{}"
var currentSensorData = "{}"

const port = 3000

server.use(express.json());

server.listen(port, (error) => {
      if(error){
        console.log('Something went wrong', error)
    }else{
        console.log('Server is listening on port ' + port)
    }
});

server.get('/toApp', (req, res) => { //send info when requested from http://IP:PORT/toApp
    res.status(200).send(currentSensorData)
});
server.get('/toSensor', (req, res) => { //send info when requested from http://IP:PORT/toSensor
    res.status(200).send(currentAppData)
});

server.post('/fromApp', (req, res) => {
  const requestData = req.body

  console.log('Received data:', requestData)

  res.status(200).json({ message: 'Data received successfully!', receivedData: requestData})

  currentAppData = requestData
});

server.post('/fromSensor', (req, res) => {
  const requestData = req.body

  console.log('Received data:', requestData)

  res.status(200).json({ message: 'Data received successfully!', receivedData: requestData})
  
  currentSensorData = requestData
});