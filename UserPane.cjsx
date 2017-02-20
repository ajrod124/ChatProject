React = require 'react'
ReactNative = require 'react-native'

{Text, View, StyleSheet, Image, ScrollView} = ReactNative

bar = '\u23af\u23af\u23af\u23af\u23af\u23af\u23af\u23af\u23af\u23af\u23af\u23af\u23af\u23af\u23af'

UserPane = React.createClass
	getInitialState: ->
		elements: []

	componentWillMount: ->
		@setState
			elements: @props.users.map @renderRow

	renderRow: (user, i) ->
		<View key={i} style={{flexDirection: 'row'}}>
			<View flexDirection='row'>
				<Image style={styles.avatar} source={{uri: 'http://fathomless-retreat-96857.herokuapp.com' + user.avatar}}/>
				<Image style={styles.online} source={{uri: 'https://images6.alphacoders.com/405/405735.jpg'}}/>
			</View>
			<View>
				<Text style={styles.text}>{user.username}</Text>
				<Text style={styles.divider}>{bar + bar}</Text>
			</View>
		</View>

	render: ->
		<View style={styles.container}>
			<View style={styles.header}>
				<Text style={[styles.text, {padding: 13.5}]}>Users</Text>
			</View>
			<ScrollView>
				<Text style={styles.text}>{'ONLINE - ' + @props.users.length}</Text>
				{@state.elements}
				<Text style={styles.text}>{'OFFLINE - 0'}</Text>
			</ScrollView>
		</View>

styles = StyleSheet.create
	header:
		flexDirection: 'row'
		backgroundColor: '#282828'
	container:
		flex: 1
		flexDirection: 'column'
		backgroundColor: '#222222'
	text:
		padding: 12
		fontSize: 12
		color: '#FFFFFF'
	avatar:
		marginTop: 7
		marginBottom: 7
		marginLeft: 15
		marginRight: 15
		height: 30
		width: 30
		borderRadius: 15
		overlayColor: '#222222'
	divider:
		paddingTop: 1.5
		paddingLeft: 5
		fontSize: 8
		color: '#444444'
	online:
		height: 10
		width: 10
		borderRadius: 5
		borderWidth: 1
		borderColor: '#222222'
		right: 25
		top: 25

module.exports = UserPane