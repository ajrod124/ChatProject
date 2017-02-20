React = require 'react'
ReactNative = require 'react-native'
moment = require 'moment'

baseURL = 'https://fathomless-retreat-96857.herokuapp.com'

{Text, View, StyleSheet, Image} = ReactNative

TextElement = React.createClass
	getInitialState: ->
		user: null

	componentWillMount: ->
		@getUser()

	getUser: ->
		for user in @props.users
			if @props.message.userId is user._id
				@setState
					user: user

	render: ->
		if @props.displayExtra
			<View style={{flexDirection: 'row'}}>
				<Image style={styles.avatar} source={{uri: 'http://fathomless-retreat-96857.herokuapp.com' + @state.user.avatar}}/>
				<View>
					<View style={{flexDirection: 'row', paddingBottom: 9}}>
						<Text style={styles.name}>{@state.user.username}</Text>
						<Text style={styles.time}>{moment(@props.message.time).calendar()}</Text>
					</View>
					<Text style={styles.text}>{@props.message.message}</Text>
				</View>
			</View>
		else
			<Text style={[styles.text, {marginLeft: 60}]}>{@props.message.message}</Text>
		

styles = StyleSheet.create
	avatar:
		marginTop: 3
		marginBottom: 7
		marginLeft: 15
		marginRight: 15
		height: 30
		width: 30
		borderRadius: 15
	name:
		fontSize: 10
		color: '#4d0099'
	time:
		paddingTop: 1.5
		paddingLeft: 5
		fontSize: 8
		color: '#444444'
	text:
		paddingBottom: 9
		fontSize: 10
		color: '#cccccc'

module.exports = TextElement