// ---------------------------------------
//	Deuces Wild Poker
//  Christian Garcia, Thias Kjaer, Jason Quinn
// ---------------------------------------

package
{
	import Events.LOADING_EVENT;
	import Extended.*;
	import flash.display3D.textures.Texture;
	import flash.sampler.NewObjectSample;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;
	import starling.events.*;
	import starling.utils.AssetManager;
	import starling.core.Starling;
	import Roulette.ROULETTE_BETS;
	import flash.utils.ByteArray;
	import DECK;
	import Card;
	import WIN;

	public class GAME extends DISPLAY
	{
		private var Deal_Button:E_BUTTON;
		private var Background_Image:E_IMAGE;
		
		//Initialize buttons
		private var Card1:E_BUTTON;
		private var Card2:E_BUTTON;
		private var Card3:E_BUTTON;
		private var Card4:E_BUTTON;
		private var Card5:E_BUTTON;
		private var Exit:E_BUTTON;
		private var Bet_Max:E_BUTTON;
		private var Bet:E_BUTTON;
		private var Bet_Less:E_BUTTON;
		private var Help:E_BUTTON;
			var show:Boolean = false;
		
		//Initialize text areas
		private var Current_Bet_Text:E_TEXT;
		private var Total_Area:E_TEXT;
		private var Game_Over:E_TEXT;
		
		// Hold images and hold array
		private var Hold_Image0: E_IMAGE;
		private var Hold_Image1: E_IMAGE;
		private var Hold_Image2: E_IMAGE;
		private var Hold_Image3: E_IMAGE;
		private var Hold_Image4: E_IMAGE;
		private var Hold = new Array(false, false, false, false, false);
		private var Is_Holdable:Boolean = false;
		
		//Paytable images
		private var Paytable1:E_IMAGE;
		private var Paytable2:E_IMAGE;
		private var Paytable3:E_IMAGE;
		private var Paytable4:E_IMAGE;
		private var Paytable5:E_IMAGE;
		private var Table_Array;
		
		//Highlight Images
		private var Highlight1:E_IMAGE;
		private var Highlight2:E_IMAGE;
		private var Highlight3:E_IMAGE;
		private var Highlight4:E_IMAGE;
		private var Highlight5:E_IMAGE;
		private var Highlight6:E_IMAGE;
		private var Highlight7:E_IMAGE;
		private var Highlight8:E_IMAGE;
		private var Highlight_Array:Array;
		
		//Help_Image
		private var Help_Image: E_IMAGE;
		
		//Win Array
		private var Win_Array = new Array(false, false, false, false, false, false, false, false);
		
		//Deck and hand array
		private var deck:DECK = new DECK();
		private var hand = new Array();
		private var Check_Hand = new Array();
		
		//private var Button_Sound:SOUND;

		private var Hold_Card:Boolean;//
		
		//These variables keep track of the players's current bet and total credits
		private var Current_Bet:int 		= 1;
		private var Total_Credits:int 		= 1000;
		
		//These values are used to display the returnings for each winning hand depending on the value of the current_bet variable
		
		private var Royal_Flush_Values		= new Array(250, 500, 750, 1000, 4000);
		private var Five_Kind_Values 	    = new Array(150, 300, 450, 600, 750);
		private var Straight_Flush_Values	= new Array(50, 100, 150, 200, 250);
		private var Four_Kind_Values 		= new Array(20, 40, 60, 80, 100);
		private var Full_House_Values 		= new Array(6, 12, 18, 24, 30);
		private var Flush_Values 			= new Array(5, 10, 15, 20, 25);
		private var Straight_Values 		= new Array(3, 6, 9, 12, 15);
		private var Three_Kind_Values 		= new Array(1, 2, 3, 4, 5);
		private var Pay_Table = new Array();		
		
		private var Win:WIN = new WIN();
		private var _Asset_Loader:ASSET_LOADER;
		private var _Assets:AssetManager;
		private var _Config:XML;
		private var _Math_Config:XML;
		private var _Directory:String;
		private var _Locality:LOCALITY;		
		

		public function GAME(directory:String)
		{
			_Directory = directory + "/";
			_Asset_Loader = new ASSET_LOADER(Directory, Asset_Loader_Handler);
			Asset_Loader.Add_Directory(Directory);
			Asset_Loader.Start();
		}
		

		private function Asset_Loader_Handler(ratio:Number):void
		{
			var Loading_Event:LOADING_EVENT = new LOADING_EVENT(LOADING_EVENT.EVENT_LOADING_STATUS);
			Loading_Event.Percentage = ratio;
			dispatchEvent(Loading_Event);

			if(ratio < 1) return;

			//Assets are what we use to get sounds, images, animations...
			_Assets			= Asset_Loader.Get_Assets();
			
			//The config file is where all the information for our text areas, image, and other variables are stored.
			_Config			= Assets.getXml("Game");
			
			//The math config is where the information about win check will be stored. 
			_Math_Config 	= Assets.getXml("Math");
			
			//Example sound. 
			//Button_Sound				= new SOUND(Assets.getSound("Button_Sound"));
			
			//Example images.  
			Background_Image			= new E_IMAGE(Assets, Config.Game.Background);
			Hold_Image0					= new E_IMAGE(Assets, Config.Game.Hold_Image0);
			Hold_Image1					= new E_IMAGE(Assets, Config.Game.Hold_Image1);
			Hold_Image2					= new E_IMAGE(Assets, Config.Game.Hold_Image2);
			Hold_Image3					= new E_IMAGE(Assets, Config.Game.Hold_Image3);
			Hold_Image4					= new E_IMAGE(Assets, Config.Game.Hold_Image4);
			
			//Paytable Image
			Paytable1					= new E_IMAGE(Assets, Config.Game.Paytable1);
			Paytable2					= new E_IMAGE(Assets, Config.Game.Paytable2);
			Paytable3					= new E_IMAGE(Assets, Config.Game.Paytable3);
			Paytable4					= new E_IMAGE(Assets, Config.Game.Paytable4);
			Paytable5					= new E_IMAGE(Assets, Config.Game.Paytable5);
			
			//Highlight Images
			Highlight1					= new E_IMAGE(Assets, Config.Game.Highlight1);
			Highlight2					= new E_IMAGE(Assets, Config.Game.Highlight2);
			Highlight3					= new E_IMAGE(Assets, Config.Game.Highlight3);
			Highlight4					= new E_IMAGE(Assets, Config.Game.Highlight4);
			Highlight5					= new E_IMAGE(Assets, Config.Game.Highlight5);
			Highlight6					= new E_IMAGE(Assets, Config.Game.Highlight6);
			Highlight7					= new E_IMAGE(Assets, Config.Game.Highlight7);
			Highlight8					= new E_IMAGE(Assets, Config.Game.Highlight8);
			Highlight_Array = new Array(Highlight1, Highlight2, Highlight3, Highlight4, Highlight5, Highlight6, Highlight7, Highlight8);
			Table_Array = new Array(Paytable1, Paytable2, Paytable3, Paytable4, Paytable5);

			//Help Image
			Help_Image					= new E_IMAGE(Assets, Config.Game.Help_Image);
			//The DISPLAY class has many different animation and movement properties that you can use. 
			//Arrow_Image.Start_Pulse(15, .2);
						
			Total_Area					= new E_TEXT(Config.Game.Total_Area);
			Current_Bet_Text			= new E_TEXT(Config.Game.Current_Bet_Text);
			Game_Over					= new E_TEXT(Config.Game.Game_Over);			
			
			//Example button and listener. 
			Deal_Button				= new E_BUTTON(Assets, Config.Game.Deal_Button);
			Deal_Button.addEventListener(BUTTON.EVENT_TOUCHED, Deal);
			
			Card1					= new E_BUTTON(Assets, Config.Game.Card1);
			Card1.addEventListener(BUTTON.EVENT_TOUCHED, function():void
			{
				if (Is_Holdable)
				{
					if (Hold[0] == false)
					{
						Hold[0] = true;
						addChild(Hold_Image0);
						Hold_Image0.touchable=false;
					}else
					{
						Hold[0] = false;
						removeChild(Hold_Image0);
					}
			}});
			
		
			Card2				= new E_BUTTON(Assets, Config.Game.Card2);
			Card2.addEventListener(BUTTON.EVENT_TOUCHED, function():void
			{
				if (Is_Holdable)
				{
					if (Hold[1] == false)
					{
						Hold[1] = true;
						addChild(Hold_Image1);
						Hold_Image1.touchable=false;
					}
					else
					{
						Hold[1] = false;
						removeChild(Hold_Image1);
					}
				
			}});			
			
			Card3				= new E_BUTTON(Assets, Config.Game.Card3);
			Card3.addEventListener(BUTTON.EVENT_TOUCHED, function():void
			{
				if (Is_Holdable)
				{
					if (Hold[2] == false)
					{
						Hold[2] = true;
						addChild(Hold_Image2);
						Hold_Image2.touchable=false;
					}else
					{
						Hold[2] = false;
						removeChild(Hold_Image2);
					}
			}});
			
			Card4				= new E_BUTTON(Assets, Config.Game.Card4);
			Card4.addEventListener(BUTTON.EVENT_TOUCHED, function():void
			{
				if (Is_Holdable)
					{
					if (Hold[3] == false)
					{
						Hold[3] = true;
						addChild(Hold_Image3);
						Hold_Image3.touchable=false;
					}else
					{
						Hold[3] = false;
						removeChild(Hold_Image3);
					}
			}});
			
			Card5				= new E_BUTTON(Assets, Config.Game.Card5);
			Card5.addEventListener(BUTTON.EVENT_TOUCHED, function():void
			{
				if (Is_Holdable)
				{
					if (Hold[4] == false)
					{
						Hold[4] = true;
						addChild(Hold_Image4);
						Hold_Image4.touchable=false;
					}else
					{
						Hold[4] = false;
						removeChild(Hold_Image4);
					}
			}});	
			
			Exit				= new E_BUTTON(Assets, Config.Game.Exit);
			//Exit.addEventListener(BUTTON.EVENT_TOUCHED, );		

			
			Bet_Max				= new E_BUTTON(Assets, Config.Game.Bet_Max);
			Bet_Max.addEventListener(BUTTON.EVENT_TOUCHED, Bet_Max_Func);		

			
			Bet					= new E_BUTTON(Assets, Config.Game.Bet);
			Bet.addEventListener(BUTTON.EVENT_TOUCHED, Bet_One);			

			
			Bet_Less			= new E_BUTTON(Assets, Config.Game.Bet_Less);
			Bet_Less.addEventListener(BUTTON.EVENT_TOUCHED, Bet_Less_Func);
			
			Help 				= new E_BUTTON(Assets, Config.Game.Help);
			Help.addEventListener(BUTTON.EVENT_TOUCHED, Help_Func);

			
			//When you have an image, animation, text field, etc. you need to make sure that you add the child to the stage or else it won't show up. 
			Add_Children([Background_Image, Card1, Card2, Card3, Card4, Card5, Deal_Button, Current_Bet_Text, Exit, Bet_Max, Bet, Bet_Less, Total_Area, Paytable1, Help]);
			
			//Listeners
			this.addEventListener(Event.ENTER_FRAME, Enter_Frame_Handler);
			//Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey_Down);
			
			//Setting up the paytable array
			Pay_Table[0] = [250, 500, 750, 1000, 4000];
			Pay_Table[1] = [150, 300, 450, 600, 750];
			Pay_Table[2] = [50, 100, 150, 200, 250];
			Pay_Table[3] = [20, 40, 60, 80, 100];
			Pay_Table[4] = [6, 12, 18, 24, 30];
			Pay_Table[5] = [5, 10, 15, 20, 25];
			Pay_Table[6] = [3, 6, 9, 12, 15];
			Pay_Table[7] = [1, 2, 3, 4, 5];
		}

		private function Enter_Frame_Handler():void
		{
			//Constantly update the instruction area with the random number. 
			Total_Area.Text				= "Total Credits: "  + Total_Credits;
			Current_Bet_Text.Text		= "Current Bet: " + Current_Bet;
			Game_Over.Text				= "Game Over";			
		}
		/*
		public function onKey_Down(keyEvent:KeyboardEvent):void
		{
			//Request a new random number when a key has been pressed. 
			//Random_Numbers.Request([36]);
		}*/
		
		//Bet one function associated with the bet one button
		//only performs its action if you are in the first case, represented by being able to hold cards and if the current bet is less than 5 and less than the total credits
		//removes the old payout tables
		//increments the current bet by 1
		//adds a payout table corresponding to the current bet
		//puts any current winning hand highlight on top of the payout table
		private function Bet_One():void
		{
			if (Current_Bet < 5 && !Is_Holdable && Current_Bet< Total_Credits)
			{
				removeChild(Table_Array[0]);
				removeChild(Table_Array[1]);
				removeChild(Table_Array[2]);
				removeChild(Table_Array[3]);
				removeChild(Table_Array[4]);
				Current_Bet++;
				addChild(Table_Array[Current_Bet - 1]);
				for (var i:int = 0; i < 8; i++)
				{
					if (Win_Array[i])
					{
						addChild(Highlight_Array[i]);
					}
				}
			}
		}
		
		//Bet less function associated with the bet less button
		//only performs its action if you are in the first case, represented by being able to hold cards and if the current bet is larger than 1, removing the possibilty for 0 or negative bets
		//removes the old payout tables
		//decrements the current bet by 1
		//adds a payout table corresponding to the current bet
		//puts any current winning hand highlight on top of the payout table
		private function Bet_Less_Func():void
		{
			if ((Current_Bet > 1 && !Is_Holdable))
			{
				
				removeChild(Table_Array[0]);
				removeChild(Table_Array[1]);
				removeChild(Table_Array[2]);
				removeChild(Table_Array[3]);
				removeChild(Table_Array[4]);
				Current_Bet--;
				addChild(Table_Array[Current_Bet - 1]);
				for (var i:int = 0; i < 8; i++)
				{
					if (Win_Array[i])
					{
						addChild(Highlight_Array[i]);
					}
				}
			}
		}
		
		//Bet max function associated with the bet max button
		//only performs its action if you are in the first case, represented by being able to hold cards
		//removes the old payout tables
		//checks if the total credits is less than what is maximally allowed to be bet. If so, set the current bet to the total, otherwise the current bet is set to 5
		//adds a payout table corresponding to the current bet
		//puts any current winning hand highlight on top of the payout table
		private function Bet_Max_Func():void
		{
			if (!Is_Holdable)
			{
				removeChild(Table_Array[0]);
				removeChild(Table_Array[1]);
				removeChild(Table_Array[2]);
				removeChild(Table_Array[3]);
				removeChild(Table_Array[4]);
				if (Total_Credits < 5)
				{
					Current_Bet = Total_Credits;
				}else
				{
					Current_Bet = 5;
				}
				
				
				addChild(Table_Array[Current_Bet - 1]);
				for (var i:int = 0; i < 8; i++)
				{
					if (Win_Array[i])
					{
						addChild(Highlight_Array[i]);
					}
				}
			}
		}
		
		private function Help_Func():void
		{
			show = !show;
			if (show == false)
			{
				removeChild(Help_Image);
			}else
			{
				addChild(Help_Image);
			}
		}
		
		private function Deal():void
		{
			Is_Holdable = !Is_Holdable; //Every other time the draw/deal button is pressed you are able to hold cards
			if (Current_Bet != 0){
				//knowing when a hand is holdable determines which case you are in
				//If you can hold cards you have just been dealt a new hand from a new deck
				if (Is_Holdable)
				{
					//Sets the current bet to 1 if the last hand was lost and put your total less than what was bet last time
					//updates the paytable image same as the bet buttons
					if (Current_Bet > Total_Credits)
					{
						Current_Bet = 1;
						removeChild(Table_Array[0]);
						removeChild(Table_Array[1]);
						removeChild(Table_Array[2]);
						removeChild(Table_Array[3]);
						removeChild(Table_Array[4]);
						
						addChild(Table_Array[Current_Bet - 1]);
						for (var i:int = 0; i < 8; i++)
						{
							if (Win_Array[i])
							{
								addChild(Highlight_Array[i]);
							}
						}
					}
					
					//Sets up a new round by removing previous labels and resetting the win array
					Remove_Hold_Labels();
					Win_Array = new Array(false, false, false, false, false, false, false, false);
					Remove_Highlight_Labels();
					
					//Creates a new deck from the DECK class
					deck = new DECK();	
					
					//resets the hold array
					for (var i:int = 0; i <= 4; i++)
					{
						Hold[i] = false;
					}
					
					//Deals cards to the hand
					for (var i:int = 0; i <= 4; i++)
					{
						hand[i] = deck.Deck_Deal();
					}
						
					/*
					 * Royal Flush test hand
					var card1:Card = new Card("C", "2");
						hand[0] = card1;
					var card2:Card = new Card("D", "2");
						hand[1] = card2;
					var card3:Card = new Card("H", "2");
						hand[2] = card3;
					var card4:Card = new Card("S", "2");
						hand[3] = card4;
					var card5:Card = new Card("D", "A");
						hand[4] = card5;
					*/
					
					
					//Deep copy of the hand since passing objects in actionscript changes the original values, affecting the winchecks
					for (var i:int = 0; i < 5; i++ )
					{
						var Copy_Card = new Card(hand[i].Get_Suit(), hand[i].Get_Value());
						Check_Hand[i] = Copy_Card;
					}
					
					//Changing the card buttons to match the cards dealt and adding actionslisteners
					Change_Card1();	Change_Card2();	Change_Card3();	Change_Card4(); Change_Card5();
					
					//Checks if the hand has a winning condition using the deep copied hand
					Win_Check(Check_Hand);
					//determines if the player can play that hand based on their credits
					if (Total_Credits <= 0)
					{
						Total_Credits = 0;
						addChild(Game_Over);
						Current_Bet = 0;
					}
				}
				//If the player cannot hold cards, then they are in the second case
				else
				{
					//sets the total credits to 0 in the case a negative value is reached and gives a game over message
					//negates the current bet from the total
					if (Total_Credits <= 0)
					{
						Total_Credits = 0;
						addChild(Game_Over);
						Current_Bet = 0;
					}else
					{
						Total_Credits -= Current_Bet;
					}
					
					//resetting the win array, since the player could have chosen to not hold a winning hand
					Win_Array = new Array(false, false, false, false, false, false, false, false);
					//Since the win is reset the labels are removed
					Remove_Highlight_Labels();
					//Deals new cards in place of the ones not held, from the same deck as the first case
					for (var i:int = 0; i <= 4; i++)
					{
						if (Hold[i] == false)
						{
							hand[i] = deck.Deck_Deal();
						}
					}
					
					//Only updates the new cards 
					if (Hold[0] == false) 
					{
						Change_Card1();
					}
					
					if (Hold[1] == false) 
					{
						Change_Card2();
					}
					
					if (Hold[2] == false) 
					{
						Change_Card3();
					}
					
					if (Hold[3] == false) 
					{
						Change_Card4();
					}
					
					if (Hold[4] == false) 
					{
						Change_Card5();
					}
					
					/*
					 * Three of a kind test hand
					var card1:Card = new Card("C", "2");
						hand[0] = card1;
					var card2:Card = new Card("D", "3");
						hand[1] = card2;
					var card3:Card = new Card("H", "3");
						hand[2] = card3;
					var card4:Card = new Card("D", "6");
						hand[3] = card4;
					var card5:Card = new Card("D", "A");
						hand[4] = card5;
					
					Change_Card1();	Change_Card2();	Change_Card3();	Change_Card4(); Change_Card5();
					*/
					
					//Deep copy
					for (var i:int = 0; i < 5; i++ )
					{
						var Copy_Card = new Card(hand[i].Get_Suit(), hand[i].Get_Value());
						Check_Hand[i] = Copy_Card;
					}
					
					//Win check
					Win_Check(Check_Hand);
					//awards the payout to the total credits
					//The bet amount determines the payout amount, which is represented as a 2 dimensional array, resembling a table of payout by bet amount 
					for (var i:int = 0; i < 8; i++)
					{
						if (Win_Array[i])
						{
							Total_Credits += Pay_Table[i][Current_Bet - 1];
						}
					}
				}
			}
		}
		
		//functions to update the images of the card buttons through getters from the Card class
		//Will update the eventlistener to make them holdable depending on the current state
		//takes the image that is positioned away from the game area and puts it on top of the button
		private function Change_Card1():void
		{
			var Card1_String:String = hand[0].Get_Suit() + hand[0].Get_Value();
			
				removeChild(Card1, false);
				Card1					= new E_BUTTON(Assets, Config.Game.child(Card1_String));
				Card1.addEventListener(BUTTON.EVENT_TOUCHED, function():void
				{
					if (Is_Holdable)
					{
						if (Hold[0] == false)
						{
							Hold[0] = true;
							addChild(Hold_Image0);
							Hold_Image0.touchable=false;
						}
						else
						{
							Hold[0] = false;
							removeChild(Hold_Image0);
						}
				}});
				Card1.Set_Position(500, 550);
				Add_Children([Card1]);
		}
		
		private function Change_Card2():void
		{
			var Card2_String:String = hand[1].Get_Suit() + hand[1].Get_Value();
				removeChild(Card2, false);
				Card2				= new E_BUTTON(Assets, Config.Game.child(Card2_String));
				Card2.addEventListener(BUTTON.EVENT_TOUCHED, function():void
				{
					if (Is_Holdable)
					{
						if (Hold[1] == false)
						{
							Hold[1] = true;
							addChild(Hold_Image1);
							Hold_Image1.touchable=false;
						}
						else
						{
							Hold[1] = false;
							removeChild(Hold_Image1);
						}
					
				}});
				Card2.Set_Position(700, 550);
				Add_Children([Card2]);
		}
		
		private function Change_Card3():void
		{
			var Card3_String:String = hand[2].Get_Suit() + hand[2].Get_Value();
				removeChild(Card3, false);
				Card3				= new E_BUTTON(Assets, Config.Game.child(Card3_String));
				Card3.addEventListener(BUTTON.EVENT_TOUCHED, function():void
				{
					if (Is_Holdable)
					{
						if (Hold[2] == false)
						{
							Hold[2] = true;
							addChild(Hold_Image2);
							Hold_Image2.touchable=false;
						}
						else
						{
							Hold[2] = false;
							removeChild(Hold_Image2);
						}
				}});
				Card3.Set_Position(900, 550);
				Add_Children([Card3]);
		}
		
		private function Change_Card4():void
		{
			var Card4_String:String = hand[3].Get_Suit() + hand[3].Get_Value();
				removeChild(Card4, false);
				Card4				= new E_BUTTON(Assets, Config.Game.child(Card4_String));
				Card4.addEventListener(BUTTON.EVENT_TOUCHED, function():void
				{
					if (Is_Holdable)
						{
						if (Hold[3] == false)
						{
							Hold[3] = true;
							addChild(Hold_Image3);
							Hold_Image3.touchable = false;
						}
						else
						{
							Hold[3] = false;
							removeChild(Hold_Image3);
						}
				}});
				Card4.Set_Position(1100, 550);
				Add_Children([Card4]);
		}
		
		private function Change_Card5():void
		{
			var Card5_String:String = hand[4].Get_Suit() + hand[4].Get_Value();
			removeChild(Card5, false);
			Card5				= new E_BUTTON(Assets, Config.Game.child(Card5_String));
			Card5.addEventListener(BUTTON.EVENT_TOUCHED, function():void
			{
				if (Is_Holdable)
				{
					if (Hold[4] == false)
					{
						Hold[4] = true;
						addChild(Hold_Image4);
						Hold_Image4.touchable = false;
					}
					else
					{
						Hold[4] = false;
						removeChild(Hold_Image4);
					}
			}});
			Card5.Set_Position(1300, 550);
			Add_Children([Card5]);
		}
		
		//Check for winning hands using the WIN class
		//The first occuring win will break the check, awarding the highest possible payout for the current hand. This simplifies the win class since we can disregard some cases for the lower hands.
		//Adds the corresponding highlight to the paytable
		//sets the corresponding position in the win array to true
		private function Win_Check(hand:Array):void
		{
			for (var i:int = 0; i < 2; i++)
			{
				if (Win.Check_Royal_Flush(hand))
				{
					addChild(Highlight_Array[0]);
					Win_Array[0] = true;
					break;
				}else if (Win.Check_5(hand))
				{
					addChild(Highlight_Array[1]);
					Win_Array[1] = true;
					break;
				}else if (Win.Check_Straight_Flush(hand))
				{
					addChild(Highlight_Array[2]);
					Win_Array[2] = true;
					break;
				}else if (Win.Check_4(hand))
				{
					addChild(Highlight_Array[3]);
					Win_Array[3] = true;
					break;
				}else if (Win.Check_Full(hand))
				{
					addChild(Highlight_Array[4]);
					Win_Array[4] = true;
					break;
				}else if (Win.Check_Flush(hand))
				{
					addChild(Highlight_Array[5]);
					Win_Array[5] = true;
					break;
				}else if (Win.Check_Straight(hand))
				{
					addChild(Highlight_Array[6]);
					Win_Array[6] = true;
					break;
				}else if (Win.Check_3(hand))
				{
					addChild(Highlight_Array[7]);
					Win_Array[7] = true;
					break;
				}else
				{
				}
			}
		}
		
		//removes all hold labels
		private function Remove_Hold_Labels():void
		{
			removeChild(Hold_Image0);
			removeChild(Hold_Image1);
			removeChild(Hold_Image2);
			removeChild(Hold_Image3);
			removeChild(Hold_Image4);
		}
		
		//removes the highlights
		private function Remove_Highlight_Labels():void
		{
			removeChild(Highlight_Array[0]);
			removeChild(Highlight_Array[1]);
			removeChild(Highlight_Array[2]);
			removeChild(Highlight_Array[3]);
			removeChild(Highlight_Array[4]);
			removeChild(Highlight_Array[5]);
			removeChild(Highlight_Array[6]);
			removeChild(Highlight_Array[7]);
		}
		
		//Getters 
		public function get Asset_Loader():ASSET_LOADER
		{
			return _Asset_Loader;
		}
		
		public function get Assets():AssetManager
		{
			return _Assets;
		}
		
		public function get Config():XML		
		{
			return _Config;
		}
		
		public function get Math_Config():XML
		{
			return _Math_Config;
		}
		
		public function get Directory():String
		{
			return _Directory;
		}
		
		public function get Locality():LOCALITY
		{
			return _Locality;
		}		
	}
}