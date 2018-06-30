const HtmlWebpackPlugin = require('html-webpack-plugin')
const HtmlWebpackInlineSourcePlugin = require('html-webpack-inline-source-plugin')

module.exports = {
	mode: 'production',
	entry: './src/index.js',
	output: {
		path: __dirname + '/build'
	},
	module: {
		rules: [
			{
				test: /\.css$/,
				use: [{ loader: 'style-loader' }, { loader: 'css-loader' }]
			}
		]
	},
	plugins: [
		new HtmlWebpackPlugin({
			minify: true,
			inject: true,
			template: './src/index.html',
			files: {
				css: ['./src/index.css']
			},
			inlineSource: '.(js|css)$'
		}),
		new HtmlWebpackInlineSourcePlugin()
	]
}
