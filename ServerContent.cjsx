React = require 'react'
ReactNative = require 'react-native'

{Text, View, StyleSheet, TouchableHighlight, ScrollView} = ReactNative

ServerContent = React.createClass
	getInitialState: ->
		channels: []
		selectedChannel: 0
		elements: []

	componentWillMount: ->
		@setState
			channels: @props.channels
		, () => @populateChannels()

	componentWillReceiveProps: (nextProps) ->
		if @props.selectedChannel isnt nextProps.selectedChannel
			@setState
				selectedChannel: nextProps.selectedChannel
			, () => @populateChannels()
		if @props.channels isnt nextProps.channels
			@setState
				channels: nextProps.channels
			, () => @populateChannels()


	populateChannels: ->
		names = @state.channels.map (channel) => channel.name 
		@setState
			elements: names.map @renderRow

	selectChannel: (i) ->
		@props.changeChannel(i)
		@props.closeDrawer()

	renderRow: (name, i) ->
		if @state.selectedChannel is i then style = styles.selected else style = styles.nomal

		<View key={i} flexDirection={'row'}>
			<TouchableHighlight onPress={@selectChannel.bind(this, i)} style={style}>
				<Text style={[styles.text, {padding: 12}]}>{'#' + name}</Text>
			</TouchableHighlight>
		</View>

	openAddChannel: ->
		@props.navigator.onAddChannel = @props.onAddChannel
		@props.navigator.push
			name: 'addchannel'

	render: ->
		<View style={styles.container}>
			<View style={styles.header}>
				<Text style={[styles.text, {padding: 13.5}]}>Stripped Down</Text>
			</View>
			<ScrollView>
				<View style={{flexDirection: 'row', justifyContent: 'space-between'}}>
					<Text style={[styles.text, {padding: 10}]}>TEXT CHANNELS</Text>
					<TouchableHighlight onPress={@openAddChannel} style={{right: 6}}>
						<Text style={[styles.text, {fontSize: 20, padding: 4}]}>+</Text>
					</TouchableHighlight>
				</View>
				{@state.elements}
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
		fontSize: 12
		color: '#FFFFFF'
	selected:
		flex: 1
		backgroundColor: '#181818'
		borderLeftWidth: 2
		borderLeftColor: '#6b7dfa'
	normal:
		flex: 1
		borderLeftWidth: 2
		borderLeftColor: '#222222'

module.exports = ServerContent