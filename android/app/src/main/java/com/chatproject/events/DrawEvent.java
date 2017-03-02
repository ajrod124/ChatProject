package com.chatproject.events;

import android.view.MotionEvent;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.uimanager.events.Event;
import com.facebook.react.uimanager.events.RCTEventEmitter;

public class DrawEvent extends Event<DrawEvent>{

    public static final String EVENT_NAME = "topChange";

    private final float mNormalizedX, mNormalizedY;
    private final int mColor, mAction;

    public DrawEvent(int viewId, float[] dims, int color, MotionEvent event) {
        super(viewId);

        mNormalizedX = event.getX()/dims[0];
        mNormalizedY = event.getY()/dims[1];
        mAction = event.getAction();
        mColor = color;
    }

    public float getNormalizedX() { return mNormalizedX; }
    public float getNormalizedY() { return mNormalizedY; }
    public int getColor() { return mColor; }
    public int getAction() { return mAction; }

    @Override
    public short getCoalescingKey() {
        return 0;
    }

    @Override
    public String getEventName() {
        return EVENT_NAME;
    }

    @Override
    public void dispatch(RCTEventEmitter rctEventEmitter) {
        rctEventEmitter.receiveEvent(getViewTag(), getEventName(), serializeEventData());
    }

    private WritableMap serializeEventData() {
        WritableMap map = Arguments.createMap();
        map.putDouble("normalizedX", getNormalizedX());
        map.putDouble("normalizedY", getNormalizedY());
        map.putInt("color", getColor());
        map.putInt("action", getAction());
        return map;
    }
}
