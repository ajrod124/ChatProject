package com.chatproject;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Path;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.view.View;

import java.util.ArrayDeque;
import java.util.Deque;

public class Whiteboard extends View {

  private Paint mPaint;
  private Deque<Path> mHistory, mRedo;
  private Path mPath;
  private int mColor, mHeight, mWidth;

  public Whiteboard(Context context) {
    super(context);
    init(context, null, 0);
  }

  public Whiteboard(Context context, AttributeSet attrs) {
    super(context, attrs);
    init(context, attrs, 0);
  }

  public Whiteboard(Context context, AttributeSet attrs, int defStyle) {
    super(context, attrs, defStyle);
    init(context, attrs, defStyle);
  }

  private void init(Context context, AttributeSet attrs, int defStyle) {
    setBackgroundColor(Color.WHITE);

    mColor = Color.BLACK;
    mHistory = new ArrayDeque<>();
    mRedo = new ArrayDeque<>();
    mPath = new Path();

    initPaint();
  }

  private void initPaint() {
    mPaint = new Paint();
    mPaint.setAntiAlias(true);
    mPaint.setDither(true);
    mPaint.setColor(mColor);
    mPaint.setStyle(Paint.Style.STROKE);
    mPaint.setStrokeJoin(Paint.Join.ROUND);
    mPaint.setStrokeCap(Paint.Cap.ROUND);
    mPaint.setStrokeWidth(12);
  }

  @Override
  protected void onDraw(Canvas canvas) {
    super.onDraw(canvas);
    canvas.drawPath(mPath, mPaint);
  }

  public void paintLocal(MotionEvent me) {
    paint(me.getX(), me.getY(), me.getAction());
  }

  public void paintRemote(double normalizedX, double normalizedY, int color, int action) {
    float[] dims = getDimensions();
    paint((float)normalizedX*dims[0], (float)normalizedY*dims[1], action);
  }

  public void paint(float x, float y, int action) {
    switch (action) {
      case MotionEvent.ACTION_DOWN:
        addHistory();
        mPath.moveTo(x, y);
        invalidate();
        break;
      case MotionEvent.ACTION_MOVE:
        mPath.lineTo(x, y);
        invalidate();
        break;
      case MotionEvent.ACTION_UP:
        mPath.lineTo(x, y);
        invalidate();
        break;
    }
  }

  public void addHistory() {
    if (mRedo.size() > 0) mRedo.clear();
    if (mHistory.size() >= 20)
      mHistory.removeFirst();
    mHistory.addLast(new Path(mPath));
  }

  public void undo() {
    if (mHistory.size() > 0) {
      mRedo.addLast(new Path(mPath));
      mPath.set(mHistory.removeLast());
      invalidate();
    }
  }

  public void clear() {
    mRedo.clear();
    mHistory.clear();
    mPath.rewind();
    invalidate();
  }

  public void redo() {
    if (mRedo.size() > 0) {
      mHistory.addLast(new Path(mPath));
      mPath.set(mRedo.removeLast());
      invalidate();
    }
  }

  public void color(int color) {
    mColor = color;
    mPaint.setColor(mColor);
    invalidate();
  }

  public float[] getDimensions() {
    float[] dims = new float[2];
    dims[0] = getWidth();
    dims[1] = getHeight();
    return dims;
  }

  public int getColor() { return mColor; }
}
