React = require 'react'
ReactNative = require 'react-native'

{PropTypes} = React
{requireNativeComponent, View, UIManager} = ReactNative

Whiteboard = React.createClass
	_onChange: (event) ->
		@props.onPaint event

	undo: ->
		UIManager.dispatchViewManagerCommand ReactNative.findNodeHandle(this),
			UIManager.RCTWhiteboard.Commands.undo, []

	redo: ->
		UIManager.dispatchViewManagerCommand ReactNative.findNodeHandle(this),
			UIManager.RCTWhiteboard.Commands.redo, []

	clear: ->
		UIManager.dispatchViewManagerCommand ReactNative.findNodeHandle(this),
			UIManager.RCTWhiteboard.Commands.clear, []

	paintRemote: (obj) ->
		hexColor = obj.color
		bbggrr = hexColor.substr(4, 2) + hexColor.substr(2, 2) + hexColor.substr(0, 2)
		color = parseInt(bbggrr, 16)

		UIManager.dispatchViewManagerCommand ReactNative.findNodeHandle(this),
			UIManager.RCTWhiteboard.Commands.paintRemote,
			[obj.normalizedX, obj.normalizedY, color, obj.action]

	render: ->
		<RCTWhiteboard style={@props.style} onChange={@_onChange}/>

Whiteboard.propTypes = View.propTypes
Whiteboard.propTypes.color = PropTypes.number
Whiteboard.propTypes.onPaint = PropTypes.func

RCTWhiteboard = requireNativeComponent 'RCTWhiteboard', Whiteboard, {nativeOnly: {onChange: true}}

module.exports = Whiteboard