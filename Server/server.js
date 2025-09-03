const http = require('http')
const fs = require('fs')

const express = require('express');
const app = express();

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

app.get('/name', (req, res) => { //send info when requested from http://IP:PORT/name
    res.status(200).send('Hello from the homepage!');
});

app.post('/name', (req, res) => { //get info when sent to http://IP:PORT/name
  const requestData = req.body;

  console.log('Received data:', requestData);
});