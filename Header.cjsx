React = require 'react'
ReactNative = require 'react-native'

{Image, Text, View, StyleSheet, TouchableHighlight, ListView} = ReactNative

Header = React.createClass
	openSettings: ->
		@props.navigator.selectedChannel = @props.name
		@props.navigator.push
			name: 'serversettings'

	openPinned: ->
		@props.navigator.selectedChannel = @props.name
		@props.navigator.push
			name: 'pinned'

	render: ->
		<View style={styles.header}>
			<View flexDirection='row'>
				<TouchableHighlight onPress={@props.openLeft}>
					<Image style={styles.img} source={require './img/list.png'}/>
				</TouchableHighlight>
				<TouchableHighlight onPress={@openSettings}>
					<Text style={styles.text}>{'#'+ @props.name + ' \u25be'}</Text>
				</TouchableHighlight>
			</View>
			<View flexDirection='row'>
				<TouchableHighlight onPress={@openPinned}>
					<Image style={styles.img} source={require './img/pinned.png'}/>
				</TouchableHighlight>
				<TouchableHighlight onPress={@props.openRight}>
					<Image style={styles.img} source={require './img/people.png'}/>
				</TouchableHighlight>
			</View>
	  </View>

styles = StyleSheet.create
	header:
		flexDirection: 'row'
		backgroundColor: '#222222'
		borderBottomColor: '#000000'
		borderBottomWidth: 1
		elevation: 5
		justifyContent: 'space-between'
	text:
		color: '#FFFFFF'
		padding: 12
	img:
		marginLeft: 6
		marginRight: 6
		marginTop: 15
		height: 15
		width: 15


module.exports = Header