React = require 'react'
ReactNative = require 'react-native'

{Image, Text, TextInput, View, StyleSheet, TouchableHighlight, ScrollView} = ReactNative

ChatInput = React.createClass
	getInitialState: ->
		text: ''
		height: 35

	submit: ->
		@props.onSubmit @state.text
		@input.clear 0
		@setState
			text: ''
			height: 35

	render: ->
		<View style={styles.textInput}>
			<TextInput 
				editable={@props.editable}
				ref={(ref) => @input = ref} 
				style={[styles.textbox, {height: @state.height}]} 
				multiline={true}
				placeholder={'Message #' + @props.name + '...'}
				placeholderTextColor='#888888'
				onChange={(event) =>
					@setState
						text: event.nativeEvent.text
						height: Math.min 67.43, event.nativeEvent.contentSize.height
				}
				underlineColorAndroid='#282828'
			/>
			<TouchableHighlight style={styles.button} onPress={@submit}>
				<Image style={styles.send} source={require './img/send.png'}/>
			</TouchableHighlight>
		</View>



styles = StyleSheet.create
	textInput:
		borderTopColor: '#111111'
		borderTopWidth: 1
		flexDirection: 'row'
		backgroundColor: '#282828'
		elevation: 5
	button:
		flex: 1
		justifyContent: 'center'
	textbox:
		paddingTop: 8
		flex: 10
		color: '#FFFFFF'
	send:
		marginLeft: 10
		height: 15
		width: 15

module.exports = ChatInput