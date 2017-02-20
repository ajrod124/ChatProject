React = require 'react'
ReactNative = require 'react-native'
moment = require 'moment'

Header = require './Header'
ServerSettings = require './ServerSettings'
ServerContent = require './ServerContent'
ChatInput = require './ChatInput'
TextElement = require './TextElement'
urls = require './urls'

bar = '   \u23af\u23af\u23af\u23af\u23af\u23af\u23af\u23af\u23af\u23af\u23af\u23af\u23af\u23af\u23af    '

{Text, View, StyleSheet, TouchableHighlight, ScrollView} = ReactNative

ChatFeed = React.createClass
	getInitialState: ->
		name: null
		messages: []
		textBoxes: []
		allowInput: false
		selectedChannel: 0

	componentWillMount: ->
		@counter = 0
		@prevMessage = null
		@populateText @props.channel
		@ws = new WebSocket urls.socketServer
		@setupSocket()

	componentWillReceiveProps: (nextProps) ->
		if @state.name? and @state.name isnt nextProps.channel.name
			@counter = 0
			@prevMessage = null
			@populateText nextProps.channel
		
	populateText: (channel) ->
		messages = channel.messages
		@setState
			name: channel.name
			messages: messages
			textBoxes: messages.map @renderRow
		
	setupSocket: ->
		@ws.onopen = () =>
			@setState
				allowInput: true
		@ws.onmessage = (e) =>
			obj = JSON.parse e.data
			switch obj.type
				when 'chatEvent'
					if obj.name is @state.name
						@updateFeed
							userId: obj.userId
							time: obj.time
							message: obj.message
				else
					console.log 'Unexpected response from socket server: ', obj
		@ws.onclose = (e) =>
			console.log e

	renderRow: (message, i) ->
		renderDivider = !@prevMessage? or !moment(@prevMessage.time).isSame(message.time, 'day')
		displayExtra = @shouldDisplayExtra message, i

		if renderDivider
			<View key={i}>
				<Text style={styles.divider}>{bar + moment(message.time).format('MMM D, YYYY') + bar}</Text>
				<TextElement message={message} users={@props.users} displayExtra={displayExtra}/>
			</View>
		else
			<TextElement key={i} message={message} users={@props.users} displayExtra={displayExtra}/>

	shouldDisplayExtra: (message, i) -> # userId, time, message
		if !@prevMessage?
			@prevMessage = message
			@counter++
			return true
		if message.time - @prevMessage.time > 3600000 or message.userId isnt @prevMessage.userId
			@counter = 0
		else
			@counter++
		@prevMessage = message
		return @counter%6 is 0

	scrollToBottom: (contentWidth, contentHeight) ->
		@messageBox.scrollTo 
			y: contentHeight
			animated: true

	addMessage: (message) ->
		time = (new Date()).getTime()
		userId = '58932274f36d2863007a8c2d'

		@ws.send JSON.stringify
			type: 'chatEvent'
			name: @state.name
			userId: userId
			time: time
			message: message

	updateFeed: (message) ->
		array = @state.messages.slice()
		array.push message

		@props.updateChannel @state.name, message

		@setState
			messages: array
			textBoxes: array.map @renderRow

	render: ->
		<View style={styles.container}>
			<Header name={@state.name} openLeft={@props.openLeft} openRight={@props.openRight} navigator={@props.navigator}/>
			<ScrollView ref={(ref) => @messageBox = ref} onContentSizeChange={@scrollToBottom}>
				{@state.textBoxes}
			</ScrollView>
			<ChatInput name={@state.name} editable={@state.allowInput} onSubmit={@addMessage}/>
		</View>

styles = StyleSheet.create
	container:
		flex: 1
		backgroundColor: '#222222'
		elevation: 1
	divider:
		paddingBottom: 9
		alignSelf: 'center'
		fontSize: 10
		color: '#444444'
		
module.exports = ChatFeed