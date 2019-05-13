const BundleAnalyzerPlugin = require('webpack-bundle-analyzer').BundleAnalyzerPlugin;
const path = require('path');

const appDirectory = path.resolve(__dirname);

module.exports = {
    mode: process.env.NODE_ENV || 'production',
    context: __dirname,
    entry: [
        // polyfill non-standard APIs
        // './src/polyfills',
        // app entry file
        // './src'
        path.join(__dirname, './index.web.js')  // 之前创建的 index.web.js 文件路径
    ],
    output: {
        path: path.resolve(appDirectory, 'dist'),
        filename: 'bundle.js'
    },
    module: {
        rules: [
            {
                test: /\.(gif|jpe?g|png|svg)$/,
                use: {
                    loader: 'file-loader'
                }
            },
            {
                test: /\.js$/,
                // include: [
                    // anything that needs to be compiled to ES5
                    // path.resolve(appDirectory, 'src')
                // ],
                use: {
                    loader: 'babel-loader',
                    options: {
                        cacheDirectory: false,
                        presets: ['module:metro-react-native-babel-preset'],
                        plugins: [
                            // needed to support async/await
                            '@babel/plugin-transform-runtime'
                        ]
                    }
                }
            }
        ]
    },
    plugins: [
        new BundleAnalyzerPlugin({
            analyzerMode: 'static',
            openAnalyzer: false
        })
    ],
    resolve: {
        alias: Object.assign(
            {
                // usle commonjs modules due to mock haste resolver aliases
                'react-native$': 'react-native-web/dist/cjs'
            },
            // mock haste resolver
            [
                'ActivityIndicator',
                'Alert',
                'AsyncStorage',
                'Button',
                'DeviceInfo',
                'Modal',
                'NativeModules',
                'Platform',
                'SafeAreaView',
                'SectionList',
                'StyleSheet',
                'Switch',
                'Text',
                'TextInput',
                'TouchableHighlight',
                'TouchableWithoutFeedback',
                'View',
                'ViewPropTypes'
            ].reduce(
                (acc, curr) => {
                    acc[curr] = `react-native-web/dist/cjs/exports/${curr}`;
                    return acc;
                },
                {
                    JSEventLoopWatchdog: 'react-native-web/dist/cjs/vendor/react-native/JSEventLoopWatchdog',
                    React$: 'react',
                    ReactNative$: 'react-native-web/dist/cjs',
                    AnExSet: path.resolve(__dirname, './src/RNTester/AnimatedGratuitousApp/AnExSet'),
                    RNTesterBlock: path.resolve(__dirname, './src/RNTester/RNTesterBlock'),
                    RNTesterPage: path.resolve(__dirname, './src/RNTester/RNTesterPage'),
                    RNTesterSettingSwitchRow: path.resolve(
                        __dirname,
                        './src/RNTester/RNTesterSettingSwitchRow'
                    ),
                    infoLog$: 'react-native-web/dist/cjs/vendor/react-native/infoLog',
                    nativeImageSource$: path.resolve(__dirname, './web/nativeImageSource')
                }
            )
        ),
        extensions: ['.web.js', '.js', '.json']
    }
};
