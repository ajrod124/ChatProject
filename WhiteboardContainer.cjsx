React = require 'react'
ReactNative = require 'react-native'
Whiteboard = require './Whiteboard'
Dimensions = require 'Dimensions'

{Text, View, StyleSheet, TouchableHighlight, Image} = ReactNative

WhiteboardContainer = React.createClass
	undo: ->
		@whiteboard.undo()

	redo: ->
		@whiteboard.redo()

	clear: ->
		@whiteboard.clear()

	paintRemote: (obj) ->
		@whiteboard.paintRemote obj

	onPaint: (event) ->

	render: ->
		<View style={styles.container}>
			<Whiteboard ref={(ref) => @whiteboard = ref} 
				style={{width: Dimensions.get('window').width, height: Dimensions.get('window').width}}
				onPaint={@onPaint}
			/>
			<View flexDirection='row'>
				<TouchableHighlight onPress={@undo} style={{flex: 1}}>
					<Text style={[styles.text, {textAlign: 'center'}]}>UNDO</Text>
				</TouchableHighlight>
				<TouchableHighlight onPress={@redo} style={{flex: 1}}>
					<Text style={[styles.text, {textAlign: 'center'}]}>REDO</Text>
				</TouchableHighlight>
				<TouchableHighlight onPress={@clear} style={{flex: 1}}>
					<Text style={[styles.text, {textAlign: 'center'}]}>CLEAR</Text>
				</TouchableHighlight>
			</View>
		</View>
		

styles = StyleSheet.create
	text:
		padding: 12
		color: 'white'
	container:
		backgroundColor: '#222222'
		elevation: 3

module.exports = WhiteboardContainer