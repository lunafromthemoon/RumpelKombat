package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import haxe.EnumFlags;
import Stake;
import flixel.ui.FlxBar;
import characters.Cholita;
/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	var lastPos:FlxPoint = new FlxPoint(0, 0);
	var cholita:Cholita;
	var armFront:PunchingArm;
	var armBack:PunchingArm;
	var armDistance:FlxPoint = new FlxPoint(-47, 5);
	var armOffset = new FlxPoint (55, 185);
	var cholitaPosition = new FlxPoint (115, 125); //x= 184 y=315
	public var gameState :State = State.RockGame;
	var stakes :Stake;
	var playerBar: FlxBar;

	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		
		var armPositionX :Float = cholitaPosition.x + armOffset.x;
		var armPositionY :Float = cholitaPosition.y + armOffset.y;
		var background = new FlxSprite (0,0, "assets/images/cafeteria.png");
		add(background);
		armBack = new PunchingArm(armPositionX-armDistance.x, armPositionY-armDistance.y, "assets/images/antebrazo.png", "assets/images/punio.png",this);
		cholita = new Cholita(cholitaPosition.x, cholitaPosition.y, "assets/images/cholita.png");
		add(cholita);
		armFront = new PunchingArm(armPositionX, armPositionY, "assets/images/antebrazo.png", "assets/images/punio.png", this);
		cholita.hp = 99;
		playerBar = new FlxBar(15, 20 , FlxBar.FILL_LEFT_TO_RIGHT , 100 , 25 , null , 0 , 100 , false );
		playerBar.createFilledBar( 0xFFB2000B , 0xFF0BFF47 , false );
		playerBar.currentValue = cholita.hp;
		add(playerBar);
		playerBar.update();
		stakes = new Stake (this);
		stakes.startRockGame();

		super.create();

	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
   		
		if ( gameState == State.Attack ) 
		{
			playerAttack();

		} else if ( gameState == Defend )
		{
			playerDefense();
		} 
   		super.update();
    }

    public function playerDefense():Void 
    {
    	var newPos:FlxPoint = FlxG.mouse.getScreenPosition();

	   	// weird math

	   	var maxAngle:Float = Math.PI/3;
	   	var minAngle:Float = -Math.PI/6;
	   	var maxPosBottom :FlxPoint = new FlxPoint ( 285, 276 );
	   	var armPosition :FlxPoint = new FlxPoint ( cholitaPosition.x + armOffset.x, cholitaPosition.y + armOffset.y );

	   	if (!FlxGeom.vequal(newPos, lastPos)) {
	   		trace (newPos);
	   		var maxRad :Float = FlxGeom.vdistsqr ( armPosition, maxPosBottom );
	   		var armAngle :Float = FlxGeom.angle ( armPosition , newPos );
	   		trace(armAngle);
	   		if (armAngle <= maxAngle && armAngle >= minAngle)
	   		{
	   			var armPoint :FlxPoint = FlxGeom.vPoint ( armPosition , maxRad , -armAngle );
	   			armFront.setFist(armPoint);
	   			armBack.setFist(new FlxPoint(armPoint.x - armDistance.x,armPoint.y-armDistance.y));
	   			 
	   		}
	   	 }    
	   	 lastPos = newPos;
    }

    public function playerAttack():Void
    {
    	var newPos:FlxPoint = FlxG.mouse.getScreenPosition();

	   	// weird math

	   	var fixedX :Int = 237;
	   	var minY :Int = 260;
	   	var maxY :Int = 405;
	   	var armPosition :FlxPoint = new FlxPoint ( cholitaPosition.x + armOffset.x, cholitaPosition.y + armOffset.y );

	   	if (!FlxGeom.vequal(newPos, lastPos)) {
	   		trace (newPos);
	   			armFront.setFist(new FlxPoint (fixedX, Math.max( Math.min( newPos.y, maxY), minY ) ) );
	   			armBack.setFist(new FlxPoint(241, 423));
	   			 
	   	 }    
	   	 lastPos = newPos;    	
    }
}