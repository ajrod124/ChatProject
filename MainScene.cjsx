React = require 'react'
ReactNative = require 'react-native'
Drawer = require('react-native-drawer').default

Header = require './Header'
ServerSettings = require './ServerSettings'
ServerContent = require './ServerContent'
ChatFeed = require './ChatFeed'
UserPane = require './UserPane'
urls = require './urls'

{Text, View, StyleSheet, TouchableHighlight, ListView} = ReactNative

MainScene = React.createClass
	getInitialState: ->
		selectedChannel: 0
		channels: []
		users: []

	componentWillMount: ->
		@getChannels()
		@getUsers()

	getChannels: ->
		fetch(urls.dbServer + '/getLast50/',
			method: 'POST'
			headers:
				'Accept': 'application/json'
				'Content-Type': 'application/json'
		).then (res) =>
			channels = JSON.parse(res._bodyText).res.reverse()
			@setState
				channels: channels

	getUsers: ->
		fetch(urls.dbServer + '/getUsers/',
			method: 'POST'
			headers:
				'Accept': 'application/json'
				'Content-Type': 'application/json'
		).then (res) =>
			@setState
				users: JSON.parse(res._bodyText).res

	updateChannelList: (list) ->
		channels = JSON.parse(list).res.reverse()
		@setState
			channels: channels

	changeChannel: (index) ->
		@setState
			selectedChannel: index

	updateChannel: (name, message) ->
		channels = @state.channels
		for channel in channels
			if channel.name is name
				channel.messages.push message
		
		@setState
			channels: channels

	openLeft: ->
		@leftDrawer.open()

	closeLeft: ->
		@leftDrawer.close()

	openRight: ->
		@rightDrawer.open()

	closeRight: ->
		@rightDrawer.close()

	render: ->
		if @state.users.length > 0 and @state.channels.length > 0
			<Drawer
				ref={(ref) => @leftDrawer = ref}
				type="overlay"
				content={<ServerContent 
					navigator={@props.navigator}
					selectedChannel={@state.selectedChannel} 
					changeChannel={@changeChannel} 
					channels={@state.channels} 
					closeDrawer={@closeLeft}
					onAddChannel={@updateChannelList}
				/>}
				tapToClose={true}
				openDrawerOffset={0.2}
				panCloseMask={0.2}
				closedDrawerOffset={-3}
				styles={drawerStyles.left}
				tweenHandler={
					(ratio) =>
						main:
							opacity: (3-(ratio*2))/3
				}
				side={'left'}
			>
				<Drawer
					ref={(ref) => @rightDrawer = ref}
					type="overlay"
					content={<UserPane 
						users={@state.users} 
						closeDrawer={@closeRight}
					/>}
					tapToClose={true}
					openDrawerOffset={0.2}
					panCloseMask={0.2}
					closedDrawerOffset={-3}
					styles={drawerStyles.right}
					tweenHandler={
						(ratio) =>
							main:
								opacity:(3-(ratio*2))/3
					}
					side={'right'}
				>
					<ChatFeed 
						users={@state.users} 
						channel={@state.channels[@state.selectedChannel]}
						openLeft={@openLeft} 
						openRight={@openRight} 
						navigator={@props.navigator}
						updateChannel={@updateChannel}
					/>
				</Drawer>
			</Drawer>
		else
			<View style={styles.container}></View>

styles = StyleSheet.create
	container:
		flex: 1
		backgroundColor: '#222222'

drawerStyles =
	left:
		drawer:
			shadowColor: '#000000'
			shadowOpacity: 0.8
			shadowRadius: 3
		main:
			paddingLeft: 3
	right:
		drawer:
			shadowColor: '#000000'
			shadowOpacity: 0.8
			shadowRadius: 3
		main:
			paddingRight: 3
		
module.exports = MainScene