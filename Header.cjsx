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
			<TouchableHighlight style={{flex: 1}} onPress={@props.openLeft}>
				<Image style={styles.img} source={require './img/list.png'}/>
			</TouchableHighlight>
			<TouchableHighlight style={{flex: 2.2}} onPress={@openSettings}>
				<Text style={styles.text}>{'#'+ @props.name + ' \u25be'}</Text>
			</TouchableHighlight>
			<Text style={{flex: 6}}/>
			<TouchableHighlight style={{flex: 1}} onPress={@openPinned}>
				<Image style={styles.img} source={require './img/pinned.png'}/>
			</TouchableHighlight>
			<TouchableHighlight style={{flex: 1}} onPress={@props.openRight}>
				<Image style={styles.img} source={require './img/people.png'}/>
			</TouchableHighlight>
	  </View>

styles = StyleSheet.create
	header:
		flexDirection: 'row'
		backgroundColor: '#222222'
		borderBottomColor: '#000000'
		borderBottomWidth: 1
		elevation: 5
	text:
		color: '#FFFFFF'
		padding: 12
	img:
		marginLeft: 10
		marginTop: 15
		height: 15
		width: 15


module.exports = Header