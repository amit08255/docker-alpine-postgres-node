const path = require('path');
const withCSS = require('@zeit/next-css');

// Used to set folders as alias to directly use in nextjs
const nextConfiguration = withCSS({
    publicRuntimeConfig: {
    // Will be available on both server and client
        REACT_APP_ENV: process.env.REACT_APP_ENV,
        NODE_ENV: process.env.NODE_ENV,
    },
    webpack: (config) => {
        const webpackConfig = config;
        webpackConfig.resolve.alias.utilities = path.join(__dirname, 'utilities'); // folder alias 1
        webpackConfig.resolve.alias.services = path.join(__dirname, 'containers'); // folder alias 2
        webpackConfig.resolve.alias.contexts = path.join(__dirname, 'contexts'); // folder alias 3
        webpackConfig.resolve.alias.components = path.join(__dirname, 'components'); // folder alias 4
        webpackConfig.resolve.alias.storeon = path.join(__dirname, 'storeon'); // folder alias 5
        webpackConfig.resolve.alias.stores = path.join(__dirname, 'stores'); // folder alias 5
        return webpackConfig;
    },
});

module.exports = nextConfiguration;
