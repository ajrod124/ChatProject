package com.chatproject;

import android.support.annotation.Nullable;
import android.util.Log;
import android.view.MotionEvent;
import android.view.View;

import com.chatproject.events.DrawEvent;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.common.MapBuilder;
import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.UIManagerModule;
import com.facebook.react.uimanager.events.EventDispatcher;

import java.util.Map;

public class WhiteboardManager extends SimpleViewManager<Whiteboard> {
	public static final int UNDO = 1, REDO = 2, SET_COLOR = 3, CLEAR = 4, PAINT_REMOTE = 5;

	public static final String REACT_CLASS = "RCTWhiteboard";

	private ThemedReactContext mContext = null;

	@Override
	public String getName() {
		return REACT_CLASS;
	}

	@Override
	public Whiteboard createViewInstance(ThemedReactContext context) {
		mContext = context;
		return new Whiteboard(context);
	}

	@Override
	public @Nullable Map<String, Integer> getCommandsMap() {
		return MapBuilder.of("undo", UNDO, "redo", REDO, "setColor",
				SET_COLOR, "clear", CLEAR, "paintRemote", PAINT_REMOTE);
	}

	@Override
	public void receiveCommand(Whiteboard root, int commandId, @Nullable ReadableArray args) {
		switch (commandId) {
			case UNDO:
				root.undo();
				break;
			case REDO:
				root.redo();
				break;
			case SET_COLOR:
				if (args != null) root.color(args.getInt(0));
				break;
			case CLEAR:
				root.clear();
				break;
			case PAINT_REMOTE:
				if (args != null)
					root.paintRemote(args.getDouble(0), args.getDouble(1),
							args.getInt(2), args.getInt(3));
				break;
		}
	}

	@Override
	protected void addEventEmitters(ThemedReactContext reactContext, Whiteboard view) {
		view.setOnTouchListener(new WhiteboardEventEmitter(
				view,
				reactContext.getNativeModule(UIManagerModule.class).getEventDispatcher()));
	}

	private static class WhiteboardEventEmitter implements View.OnTouchListener {

		private final Whiteboard mWhiteboard;
		private final EventDispatcher mEventDispatcher;

		public WhiteboardEventEmitter(Whiteboard wb, EventDispatcher ed) {
			mWhiteboard = wb;
			mEventDispatcher = ed;
		}

		@Override
		public boolean onTouch(View v, MotionEvent event) {
			mEventDispatcher.dispatchEvent(new DrawEvent(mWhiteboard.getId(),
					mWhiteboard.getDimensions(), mWhiteboard.getColor(), event));

			mWhiteboard.paintLocal(event);

			return true;
		}
	}
}