
package ;

import flixel.util.FlxRandom;
import flixel.ui.FlxButton;

class Stake 
{

	var playerStake :Int = 0;
	public var rockGameResult :Int;
	public var rockButton :FlxButton;
	public var paperButton :FlxButton;
	public var scissorsButton :FlxButton;
	public var currentStage :PlayState;

	public function new ( stage:PlayState ) 
	{
		rockButton = new FlxButton ( 325, 350, "Rock", choseRock );
		paperButton = new FlxButton ( 325, 375, "Paper", chosePaper );
		scissorsButton = new FlxButton ( 325, 400, "Scissors", choseScissors );
		currentStage = stage;
		rockGameResult = 0;
	}

	public function startRockGame ()
	{
		rockGameResult = 0;
		
		currentStage.add( rockButton );
		currentStage.add( paperButton );
		currentStage.add( scissorsButton );
	}

	public function endRockGame ()
	{
		currentStage.remove( rockButton );
		currentStage.remove( paperButton );
		currentStage.remove( scissorsButton );
	}

	public function decideStakes ( playerStake:Int, enemyStake:Int ) 
	{

    	var next :Int = (playerStake + 1) % 3;
    	
    	if ( playerStake == enemyStake ) {

    		rockGameResult = 0;
    		trace ( "draw" );

    	} else if ( enemyStake == next ) {

    		rockGameResult = 1;
            currentStage.gameState = Defend;
            endRockGame ();
    		trace ( "enemy" );
    	
    	} else {

    		rockGameResult = 2;
            currentStage.gameState = Attack;
    		endRockGame ();
            trace ( "player" );
    	}

    }

    public function choseRock() 
    {

    	var enemyStake :Int = FlxRandom.intRanged ( 0, 2);
    	playerStake = 0;
    	
    	decideStakes (playerStake, enemyStake);
    }

    public function chosePaper() 
    {

    	var enemyStake :Int = FlxRandom.intRanged ( 0, 2);
    	playerStake = 1;

    	decideStakes (playerStake, enemyStake);
    }

    public function choseScissors() 
    {

        var enemyStake :Int = FlxRandom.intRanged ( 0, 2);
    	playerStake = 2;
    	
    	decideStakes (playerStake, enemyStake);
    }

}