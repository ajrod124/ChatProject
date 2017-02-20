React = require 'react'
ReactNative = require 'react-native'

{Text, View, StyleSheet, TouchableHighlight, Image} = ReactNative

ServerSettings = React.createClass
	render: ->
		<View style={{flex: 1}}>
			<View style={styles.header} flexDirection='row'>
				<TouchableHighlight onPress={() => @props.navigator.pop()}>
					<Image style={styles.arrow} source={require './img/arrow.png'}/>
				</TouchableHighlight>
				<View style={{left: 10}}>
					<Text style={styles.headerText}>Channel Settings</Text>
					<Text style={styles.headerSubtext}>{'#' + @props.channelName}</Text>
				</View>
			</View>
			<View style={styles.container}>
				<Text style={styles.bodyText}>Channel Settings go here</Text>
			</View>
		</View>

styles = StyleSheet.create
	header:
		elevation: 5
		backgroundColor: '#6b7dfa'
	headerText:
		color: 'white'
		fontSize: 10
		paddingTop: 5
		paddingBottom: 2
	headerSubtext:
		color: 'white'
		padding: 2
		fontSize: 8
	container:
		elevation: 1
		backgroundColor: 'white'
		flex: 1
	bodyText:
		padding: 12
	arrow:
		marginTop: 15
		marginBottom: 15
		marginLeft: 20
		marginRight: 25
		width: 10
		height: 10

module.exports = ServerSettings