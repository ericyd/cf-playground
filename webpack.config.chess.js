/*
 * Credit: https://medium.com/@adamrackis/vendor-and-code-splitting-in-webpack-2-6376358f1923
 * (with modifications)
 */


var BundleAnalyzerPlugin = require('webpack-bundle-analyzer').BundleAnalyzerPlugin;
var path = require('path');
var webpack = require('webpack');
var noVisualization = process.env.NODE_ENV === 'production' 
        || process.argv.slice(-1)[0] == '-p'
		|| process.argv.some(arg => arg.indexOf('webpack-dev-server') >= 0)
		|| true; // remove if you want to see the visualization

module.exports = {
    entry: {
        main: './chess-src/index.js'
    },
    output: {
        filename: '[name]-bundle.js',
        chunkFilename: '[name]-chunk.js',
        path: path.join(path.resolve(__dirname, 'assets'), 'js', 'chess'),
        publicPath: path.join(path.resolve(__dirname, 'assets'), 'js', 'chess')
    },
    resolve: {
        modules: [
            path.resolve('./'),
            path.resolve('./node_modules'),
        ]
    },
    module: {
        loaders: [
            {
                test: /\.js$/,
                exclude: /node_modules/,
                loader: 'babel-loader',
                query: {
                    presets: ['env']
                }
            }
        ]
    },
    plugins: [
        (!noVisualization ? 
            new BundleAnalyzerPlugin({
                analyzerMode: 'static'
            }) : null),

        new webpack.optimize.CommonsChunkPlugin({
            name: 'react-build',
            minChunks(module, count) {
                var context = module.context;
                return context && (context.indexOf('node_modules\\react\\') >= 0 || context.indexOf('node_modules\\react-dom\\') >= 0);
            },
        }),

        new webpack.optimize.CommonsChunkPlugin({
            name: 'manifest'
        }),        

        //*********************************** async chunks*************************
/* 
        //catch all - anything used in more than one place
        new webpack.optimize.CommonsChunkPlugin({
            async: 'used-twice',
            minChunks(module, count) {
                return count >= 2;
            },
        }),

        //specifically bundle these large things
        new webpack.optimize.CommonsChunkPlugin({
            async: 'react-dnd',
            minChunks(module, count) {
                var context = module.context;
                var targets = ['react-dnd', 'react-dnd-html5-backend', 'react-dnd-touch-backend', 'dnd-core']
                return context && context.indexOf('node_modules') >= 0 && targets.find(t => new RegExp('\\\\' + t + '\\\\', 'i').test(context));
            },
        }), */
    ].filter(p => p),
    devtool: 'cheap-module-eval-source-map'
};