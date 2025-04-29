// index.js
exports.handler = async (event) => {
  console.log('Lambda se ejecutó correctamente');
  console.log('Received event:', JSON.stringify(event, null, 2));
  
  return {
    statusCode: 200,
    body: JSON.stringify('Hello from Lambda!'),
  };
};