module.exports = {
    presets: [
        'next/babel',
        ['@babel/preset-env', { modules: false }],
    ],
    plugins: [
        ['@babel/plugin-proposal-class-properties'],
        ['@babel/plugin-transform-runtime', {
            asyncGenerators: false,
            generators: false,
            async: false,
        }],
        ['module-resolver', {
            root: ['./dist'],
            alias: {
                utilities: './utilities',
                services: './services',
                contexts: './contexts',
                components: './components',
                containers: './containers',
                storeon: './storeon',
                stores: './stores',
            },
        }],
        [
            'styled-components',
            {
                ssr: true,
                displayName: true,
                preprocess: false,
            },
        ],
    ],
};
