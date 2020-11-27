import express from 'express';
// passport stuff
import passport from 'passport';
import logger from 'morgan';
import cookieParser from 'cookie-parser';
import bodyParser from 'body-parser';
import compression from 'compression';
import session from 'cookie-session';
import next from 'next';

// const LocalStrategy = require('passport-local').Strategy;

const dev = process.env.NODE_ENV !== 'production';
const app = next({ dev });

const handle = app.getRequestHandler();

const port = process.env.PORT || 7000;

app
    .prepare()
    .then(() => {
        const server = express();

        server.use(compression());
        server.use(logger('dev'));
        server.use(cookieParser());

        // initialize express-session to allow us track the logged-in user across sessions.
        const expiryDate = new Date(Date.now() + 60 * 60 * 1000); // 1 hour

        server.use(session({
            name: 'loan-manag-08255', // cookie name
            keys: ['loan', 'web08255'], // used to sign and verify cookie
            maxAge: 24 * 60 * 60 * 1000, // 24 hours
            cookie: {
                httpOnly: true,
                expires: expiryDate,
            },
        }));

        server.use(bodyParser.urlencoded({ extended: false }));
        server.use(bodyParser.json());

        server.use(passport.initialize());
        server.use(passport.session());

        /* passport.use(new LocalStrategy(validateUserCredentials));

        passport.serializeUser(serializeSessionUser);

        passport.deserializeUser(deserialiseSessionUser); */

        // route for index page
        server.get('/', (req, res) => {
            const actualPage = '/index';
            const queryParams = {};

            app.render(req, res, actualPage, queryParams);
        });

        server.get('*', (req, res) => handle(req, res));

        server.listen(port, (err) => {
            if (err) throw err;
            // eslint-disable-next-line no-console
            console.log('\n\nListening on port: ', port);
        });
    })
    .catch((ex) => {
        // eslint-disable-next-line no-console
        console.error(ex.stack);
        process.exit(1);
    });
