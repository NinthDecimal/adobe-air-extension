package  
{
import com.kiip.extensions.events.KiipEvent;
import com.kiip.extensions.Kiip;
import com.kiip.extensions.KiipGender;
import flash.desktop.NativeApplication;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Rectangle;
import flash.text.TextField;

/** Kiip Example App */
public class KiipExample extends Sprite
{
	//
	// Definitions
	//
	
	/** APP ID */
	public static const APP_ID:String="YOUR_APP_ID_HERE";
	
	/** App Secret */
	public static const APP_SECRET:String="YOUR_APP_SECRET_HERE";
	
	/** Test Moment ID */
	public static const MOMENT_ID:String="test_id";

	//
	// Instance Variables
	//
	
	/** Status */
	private var txtStatus:TextField;
	
	/** Buttons */
	private var buttonContainer:Sprite;
	
	//
	// Public Methods
	//
	
	/** Create New KiipExample */
	public function KiipExample() 
	{		
		createUI();
		
		if (!Kiip.isSupported())
		{
			log("Kiip not supported on this platform (not android or ios!)");
			return;
		}
		
		if (APP_ID=="YOUR_APP_ID_HERE" || APP_SECRET=="YOUR_APP_SECRET_HERE")
		{
			log("Please fill in your APP_ID and APP_SECRET in KiipExample.as.");
			return;
		}
		
		log("Initializing Kiip.");
		
		// if you are targeting BOTH android AND iOS from one code base, init like this:
		// Kiip.create("ios_app_id","ios_app_secret","android_app_id","android_app_secret");
		Kiip.create(APP_ID, APP_SECRET);

		// All Event Listeners are optional.
		
		// feedback when premium content is received, or a moment is posted
		Kiip.kiip.addEventListener(KiipEvent.CONTENT_RECEIVED,onContentReceived);
		Kiip.kiip.addEventListener(KiipEvent.MOMENT_SAVED,onMomentSaved);
		Kiip.kiip.addEventListener(KiipEvent.SAVE_MOMENT_FAILED, onMomentFailed);
		
		// feedback when a poptart is displayed.  you may wish to use these to pause the game or pause sounds, depending on the state.
		Kiip.kiip.addEventListener(KiipEvent.POPTART_DISPLAYED, onPoptartDisplayed);
		Kiip.kiip.addEventListener(KiipEvent.POPTART_DISMISSED, onPoptartDismissed);
		
		// optionally listen to session changes
		Kiip.kiip.addEventListener(KiipEvent.SESSION_STARTED, onSessionStarted);
		Kiip.kiip.addEventListener(KiipEvent.SESSION_START_FAILED, onSessionStartFailed);
		Kiip.kiip.addEventListener(KiipEvent.SESSION_ENDED, onSessionEnded);
		Kiip.kiip.addEventListener(KiipEvent.SESSION_END_FAILED, onSessionEndFailed);
		
		// finer grained feedback on the display of notification and modal views.
		Kiip.kiip.addEventListener(KiipEvent.NOTIFICATION_DISPLAYED, onNotificaitonDisplayed);
		Kiip.kiip.addEventListener(KiipEvent.NOTIFICATION_DISMISSED, onNotificationDismissed);
		Kiip.kiip.addEventListener(KiipEvent.NOTIFICATION_CLICKED, onNotificationClicked);
		
		Kiip.kiip.addEventListener(KiipEvent.MODAL_DISPLAYED, onModalDisplayed);
		Kiip.kiip.addEventListener(KiipEvent.MODAL_DISMISSED, onModalDismissed);
	}
	
	/** Save Moment */
	public function saveMoment():void
	{
		log("Saving moment...");
		Kiip.kiip.saveMoment(MOMENT_ID);
		log("Finished calling saveMoment().");
	}
	
	/** Save Moment with a value */
	public function saveMomentWithValue():void
	{
		log("Saving moment with value 1.00...");
		Kiip.kiip.saveMoment(MOMENT_ID,1.00);
		log("finished calling saveMoment() with value 1.00");
	}
	

	/** Set User Params */
	public function setUserParams():void
	{
		log("setting user params..");
		Kiip.kiip.setBirthday(new Date());
		Kiip.kiip.setEmail("kip@kiip.com");
		Kiip.kiip.setGender(KiipGender.MALE);
		//The boolean value to receive test rewards in developement/debug mode. Default is NO.
		//Change to false for production.
		Kiip.kiip.setTestMode(true);
		log("finished setting user params.");
	}

	//
	// Events
	//	
	
	/** A moment was successfully saved */
	private function onMomentSaved(e:KiipEvent):void
	{
		log("Received MomentSaved:"+e.momentId+",value="+e.value);
	}
	
	/** A branded moment has failed to save */
	private function onMomentFailed(e:KiipEvent):void
	{
		log("Moment Save Failed:'"+e.momentId+"' error:"+e.errorMessage);
	}

	/** A session successfully started */
	private function onSessionStarted(e:KiipEvent):void
	{
		log("SessionStarted");
	}
	
	/** A session start failed */
	private function onSessionStartFailed(e:KiipEvent):void
	{
		log("Session Start Failed:"+e.errorMessage);
	}

	/** A session successfully ended */
	private function onSessionEnded(e:KiipEvent):void
	{
		log("Session Ended");
	}
	
	/** A session end failed */
	private function onSessionEndFailed(e:KiipEvent):void
	{
		log("Session End Failed:"+e.errorMessage);
	}

	/** PopTart Displayed */
	private function onPoptartDisplayed(e:KiipEvent):void
	{
		log("Poptart Displayed");
	}

	/** Poptart dismissed */
	private function onPoptartDismissed(e:KiipEvent):void
	{
		log("Poptart Dismissed.."+lastContentString);
	}

	/** Modal Displayed */
	private function onModalDisplayed(e:KiipEvent):void
	{
		log("modal displayed.");
	}

	/** Modal Dismissed */
	private function onModalDismissed(e:KiipEvent):void
	{
		log("modal dismissed");
	}

	/** Notification Displayed */
	private function onNotificaitonDisplayed(e:KiipEvent):void
	{
		log("Notification displayed");
	}

	/** Notification Clicked */
	private function onNotificationClicked(e:KiipEvent):void
	{
		log("Notification Clicked");
	}

	/** Notification Dismissed */
	private function onNotificationDismissed(e:KiipEvent):void
	{
		log("Notification dismissed");
	}
	
	/** Last Content String Saved so we can see it over the poptart callback while debugging */
	private var lastContentString:String="";
	
	/** Content Received */
	private function onContentReceived(e:KiipEvent):void
	{
		lastContentString="content: "+e.contentId+"|"+e.quantity+"|"+e.transactionId+"|"+e.signature;
		log("Received "+lastContentString);
	}

	//
	// Impelementation
	//
	
	/** Create UI */
	public function createUI():void
	{
		txtStatus=new TextField();
		txtStatus.defaultTextFormat=new flash.text.TextFormat("Arial",25);
		txtStatus.width=stage.stageWidth;
		txtStatus.height=200;
		txtStatus.multiline=true;
		txtStatus.wordWrap=true;
		txtStatus.text="Ready";
		addChild(txtStatus);
		
		if (buttonContainer)
		{
			removeChild(buttonContainer);
			buttonContainer=null;
		}
		
		buttonContainer=new Sprite();
		buttonContainer.y=txtStatus.height;
		addChild(buttonContainer);
		
		var uiRect:Rectangle=new Rectangle(0,0,stage.stageWidth,stage.stageHeight);
		var layout:ButtonLayout=new ButtonLayout(uiRect,14);
		layout.addButton(new SimpleButton(new Command("Save Moment",saveMoment)));
		layout.addButton(new SimpleButton(new Command("Save Moment With Value",saveMomentWithValue)));
		layout.addButton(new SimpleButton(new Command("Set Params", setUserParams)));
	
		layout.attach(buttonContainer);
		layout.layout();	
	}
	
	/** Log */
	private function log(msg:String):void
	{
		trace("[Kiip] "+msg);
		txtStatus.text=msg;
	}	
	
}
}


import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

/** Simple Button */
class SimpleButton extends Sprite
{
	//
	// Instance Variables
	//
	
	/** Command */
	private var cmd:Command;
	
	/** Width */
	private var _width:Number;
	
	/** Label */
	private var txtLabel:TextField;
	
	//
	// Public Methods
	//
	
	/** Create New SimpleButton */
	public function SimpleButton(cmd:Command)
	{
		super();
		this.cmd=cmd;
		
		mouseChildren=false;
		mouseEnabled=buttonMode=useHandCursor=true;
		
		txtLabel=new TextField();
		txtLabel.defaultTextFormat=new TextFormat("Arial",32,0xFFFFFF);
		txtLabel.mouseEnabled=txtLabel.mouseEnabled=txtLabel.selectable=false;
		txtLabel.text=cmd.getLabel();
		txtLabel.autoSize=TextFieldAutoSize.LEFT;
		
		redraw();
		
		addEventListener(MouseEvent.CLICK,onSelect);
	}
	
	/** Set Width */
	override public function set width(val:Number):void
	{
		this._width=val;
		redraw();
	}

	
	/** Dispose */
	public function dispose():void
	{
		removeEventListener(MouseEvent.CLICK,onSelect);
	}
	
	//
	// Events
	//
	
	/** On Press */
	private function onSelect(e:MouseEvent):void
	{
		this.cmd.execute();
	}
	
	//
	// Implementation
	//
	
	/** Redraw */
	private function redraw():void
	{		
		txtLabel.text=cmd.getLabel();
		_width=_width||txtLabel.width*1.1;
		
		graphics.clear();
		graphics.beginFill(0x444444);
		graphics.lineStyle(2,0);
		graphics.drawRoundRect(0,0,_width,txtLabel.height*1.1,txtLabel.height*.4);
		graphics.endFill();
		
		txtLabel.x=_width/2-(txtLabel.width/2);
		txtLabel.y=txtLabel.height*.05;
		addChild(txtLabel);
	}
}

/** Button Layout */
class ButtonLayout
{
	private var buttons:Array;
	private var rect:Rectangle;
	private var padding:Number;
	private var parent:DisplayObjectContainer;
	
	public function ButtonLayout(rect:Rectangle,padding:Number)
	{
		this.rect=rect;
		this.padding=padding;
		this.buttons=new Array();
	}
	
	public function addButton(btn:SimpleButton):uint
	{
		return buttons.push(btn);
	}
	
	public function attach(parent:DisplayObjectContainer):void
	{
		this.parent=parent;
		for each(var btn:SimpleButton in this.buttons)
		{
			parent.addChild(btn);
		}
	}
	
	public function layout():void
	{
		var btnX:Number=rect.x+padding;
		var btnY:Number=rect.y;
		for each( var btn:SimpleButton in this.buttons)
		{
			btn.width=rect.width-(padding*2);
			btnY+=this.padding;
			btn.x=btnX;
			btn.y=btnY;
			btnY+=btn.height;
		}
	}
}

/** Inline Command */
class Command
{
	/** Callback Method */
	private var fnCallback:Function;
	
	/** Label */
	private var label:String;
	
	//
	// Public Methods
	//
	
	/** Create New Command */
	public function Command(label:String,fnCallback:Function)
	{
		this.fnCallback=fnCallback;
		this.label=label;
	}
	
	//
	// Command Implementation
	//
	
	/** Get Label */
	public function getLabel():String
	{
		return label;
	}
	
	/** Execute */
	public function execute():void
	{
		fnCallback();
	}
}
