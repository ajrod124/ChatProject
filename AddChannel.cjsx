React = require 'react'
ReactNative = require 'react-native'
urls = require './urls'

{Keyboard, TextInput, Text, View, StyleSheet, TouchableHighlight, Image} = ReactNative

AddChannel = React.createClass
	getInitialState: ->
		enableSubmit: false
		name: ''
		yPos: 20

	componentWillMount: ->
		@showListener = Keyboard.addListener 'keyboardDidShow', @keyboardDidShow
		@hideListener = Keyboard.addListener 'keyboardDidHide', @keyboardDidHide

	componentWillUnmount: ->
		@showListener.remove()
		@hideListener.remove()

	keyboardDidHide: () ->
		@setState
			yPos: 20

	keyboardDidShow: (e) ->
		@setState
			yPos: e.endCoordinates.height + 20

	submitChannel: ->
		fetch(urls.dbServer + '/addChannel/',
			method: 'POST'
			headers:
				'Accept': 'application/json'
				'Content-Type': 'application/json'
			body: JSON.stringify
				name: @state.name
		).then (res) =>
			@props.onAddChannel res._bodyText
			@props.navigator.pop()

	render: ->
		opacity = 0
		if @state.enableSubmit then opacity = 1
		<View style={{flex: 1}}>
			<View style={styles.header} flexDirection='row'>
				<TouchableHighlight onPress={() => @props.navigator.pop()}>
					<Image style={styles.arrow} source={require './img/arrow.png'}/>
				</TouchableHighlight>
				<View style={{left: 10}}>
					<Text style={styles.headerText}>Create Text Channel</Text>
					<Text style={styles.headerSubtext}>Stripped Down</Text>
				</View>
			</View>
			<View style={styles.container}>
				<Text style={styles.bodyText}>CHANNEL NAME</Text>
				<TextInput
					style={styles.input}
					onChangeText={(text) =>
						@setState
							name: text
							enableSubmit: text.length > 0
					}
					placeholder='Channel Name'
					placeholderTextColor='#cccccc'
					underlineColorAndroid='#ffffff'
				/>
			</View>
			<View style={[styles.submit, {opacity: opacity, bottom: @state.yPos}]}>
				<TouchableHighlight onPress={@submitChannel} disabled={!@state.enableSubmit}>
					<Text style={styles.submitText}>{'\u2714'}</Text>
				</TouchableHighlight>
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
		paddingLeft: 10
		paddingRight: 10
		elevation: 1
		backgroundColor: '#f5f5f5'
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
	input:
		paddingTop: 4
		paddingBottom: 4
		paddingLeft: 10
		paddingRight: 10
		borderTopColor: '#fafafa'
		borderTopWidth: 1
		flexDirection: 'row'
		backgroundColor: '#ffffff'
		elevation: 5
	submitText:
		color: 'white'
		fontSize: 30
		paddingTop: 6
	submit:
		alignItems: 'center'
		elevation: 5
		position: 'absolute'
		width: 60
		height: 60
		right: 20
		borderRadius: 30
		backgroundColor: '#6b7dfa'

module.exports = AddChannel