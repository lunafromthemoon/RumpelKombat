
package ;

import flixel.util.FlxRandom;
import flixel.ui.FlxButton;

class Stake 
{

	var playerStake :Int = 0;

	public function new ( stage:PlayState ) 
	{
		var rockButton :FlxButton = new FlxButton ( 325, 350, "Rock", choseRock );
		var paperButton :FlxButton = new FlxButton ( 325, 375, "Paper", chosePaper );
		var scissorsButton :FlxButton = new FlxButton ( 325, 400, "Scissors", choseScissors );

		stage.add( rockButton );
		stage.add( paperButton );
		stage.add( scissorsButton );
	}

	public function decideStakes ( playerStake:Int, enemyStake:Int ) 

	{

    	var next :Int = (playerStake + 1) % 3;
    	
    	if ( playerStake == enemyStake ) {

    		trace ( "draw" );

    	} else if ( enemyStake == next ) {

    		trace ( "enemy" );
    	
    	} else {

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