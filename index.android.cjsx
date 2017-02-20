React = require 'react'
ReactNative = require 'react-native'
MainScene = require './MainScene'
ServerSettings = require './ServerSettings'
PinnedMessages = require './PinnedMessages'
AddChannel = require './AddChannel'

{ AppRegistry, StyleSheet, Text, View, Image, Navigator } = ReactNative

ChatProject = React.createClass
	render: ->
		<Navigator
			initialRoute={name: 'main', index: 0}
			sceneStyle={{backgroundColor: '#000000'}}
			renderScene={
				(route, navigator) =>
					switch route.name
						when 'main'
							<MainScene navigator={navigator}/>
						when 'serversettings'
							<ServerSettings channelName={navigator.selectedChannel} navigator={navigator}/>
						when 'pinned'
							<PinnedMessages channelName={navigator.selectedChannel} navigator={navigator}/>
						when 'addchannel'
							<AddChannel navigator={navigator} onAddChannel={navigator.onAddChannel}/>
			}
			configureScene={
				(route, routeStack) =>
					Navigator.SceneConfigs.FloatFromBottom
			}
		/>

AppRegistry.registerComponent 'ChatProject', => ChatProject