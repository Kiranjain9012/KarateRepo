function fn() {    
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }

  var config = {
      baseURL: 'https://conduit.productionready.io/api/'
  }

  if (env == 'dev') {

    config.userEmail = 'karate9012@test.com'
    config.userPassword = 'Karate12345'

  } else if (env == 'qa') {

    config.userEmail = 'karate1209@test.com'
    config.userPassword = 'Karate54321'
  }

  var accessToken = karate.callSingle('classpath:helpers/generateToken.feature', config).authToken
  karate.configure('headers', {Authorization: 'Token '+ accessToken})
  return config;
}