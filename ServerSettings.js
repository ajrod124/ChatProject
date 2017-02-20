// Generated by CoffeeScript 1.12.2
(function() {
  var Image, React, ReactNative, ServerSettings, StyleSheet, Text, TouchableHighlight, View, styles;

  React = require('react');

  ReactNative = require('react-native');

  Text = ReactNative.Text, View = ReactNative.View, StyleSheet = ReactNative.StyleSheet, TouchableHighlight = ReactNative.TouchableHighlight, Image = ReactNative.Image;

  ServerSettings = React.createClass({displayName: "ServerSettings",
    render: function() {
      return React.createElement(View, {
        "style": {
          flex: 1
        }
      }, React.createElement(View, {
        "style": styles.header,
        "flexDirection": 'row'
      }, React.createElement(TouchableHighlight, {
        "onPress": ((function(_this) {
          return function() {
            return _this.props.navigator.pop();
          };
        })(this))
      }, React.createElement(Image, {
        "style": styles.arrow,
        "source": require('./img/arrow.png')
      })), React.createElement(View, {
        "style": {
          left: 10
        }
      }, React.createElement(Text, {
        "style": styles.headerText
      }, "Channel Settings"), React.createElement(Text, {
        "style": styles.headerSubtext
      }, '#' + this.props.channelName))), React.createElement(View, {
        "style": styles.container
      }, React.createElement(Text, {
        "style": styles.bodyText
      }, "Channel Settings go here")));
    }
  });

  styles = StyleSheet.create({
    header: {
      elevation: 5,
      backgroundColor: '#6b7dfa'
    },
    headerText: {
      color: 'white',
      fontSize: 10,
      paddingTop: 5,
      paddingBottom: 2
    },
    headerSubtext: {
      color: 'white',
      padding: 2,
      fontSize: 8
    },
    container: {
      elevation: 1,
      backgroundColor: 'white',
      flex: 1
    },
    bodyText: {
      padding: 12
    },
    arrow: {
      marginTop: 15,
      marginBottom: 15,
      marginLeft: 20,
      marginRight: 25,
      width: 10,
      height: 10
    }
  });

  module.exports = ServerSettings;

}).call(this);