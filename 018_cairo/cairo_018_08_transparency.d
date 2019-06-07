import std.stdio;
import std.conv;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import cairo.Context;
import gtk.DrawingArea;
import gdk.Pixbuf;

void main(string[] args)
{
	Main.init(args);

	TestRigWindow myTestRig = new TestRigWindow("Test Rig");
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	AppBox appBox;
	
	this(string title)
	{
		super(title);
		setSizeRequest(640, 360);
		
		addOnDestroy(&quitApp);
		
		appBox = new AppBox();
		add(appBox);
		
		showAll();

	} // this() CONSTRUCTOR
	
		
	void quitApp(Widget widget)
	{
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class myAppWindow


class AppBox : Box
{
	MyDrawingArea myDrawingArea;
	
	this()
	{
		super(Orientation.VERTICAL, 10);
		
		myDrawingArea = new MyDrawingArea();
		
		packStart(myDrawingArea, true, true, 0); // LEFT justify
		
	} // this()

} // class AppBox


class MyDrawingArea : DrawingArea
{
	GtkAllocation size; // the area assigned to the DrawingArea by its parent
	Pixbuf pixbuf; // an 8-bit/pixel image buffer
	
	this()
	{
		addOnDraw(&onDraw);
		
	} // this()
	
	bool onDraw(Scoped!Context context, Widget w)
	{
		int i;
		
		// middle gray background
		context.setSourceRgba(0.75, 0.75, 0.75, 1.0); // middle gray
		context.paint();
		
		// draw the blue line
		context.setLineWidth(20);
		context.setSourceRgba(0.384, 0.914, 0.976, 1.0);
		context.moveTo(10, 166);
		context.lineTo(630, 166);
		context.stroke();
		
		// 10 yellow rectangles with graduating transparency
		for(i = 0; i < 11; i++)
		{
			context.setSourceRgba(0.965, 1.0, 0.0, (i * 0.1));
			context.rectangle(((i * 64) + 10), 150, 32, 32);
			context.fill();
		}
		
		return(true);
		
	} // onDraw()
	
} // class MyDrawingArea
