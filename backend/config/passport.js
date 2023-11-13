const StrategyJwt = require('passport-jwt').Strategy;
const ExtractJWT = require('passport-jwt').ExtractJwt;
const User = require('../models/user_model');
const key = require('./keys');

module.exports = function(passport){
    let opts = {};
    opts.jwtFromRequest = ExtractJWT.fromAuthHeaderWithScheme('jwt');
    opts.secretOrKey = key.secretOrKey;
    passport.use(new StrategyJwt( opts, (jwt_payload, done) =>{
        User.getById(jwt_payload.id, (err, user) =>{
            if(err){
                return done(err, false);
            }
            if(user){
                return done(null, user);
            }
            else{
                return done(null, false);
            }
        })
    }));
} 
