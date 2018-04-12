package 
{
	import Card;
	import DECK;
	import GAME;
	/**
	 * ...
	 * @author Thias
	 */
	public class WIN 
	{		
		public function WIN()
		{
			
		}
		
		//Checks for full house
		//Sorts by value first, checks possible full house combinations or two's
		public function Check_Full(hand:Array):Boolean
		{
			var a1:Boolean;
			var a2:Boolean;
			
			hand = Sort_Value(hand);
			
			a1 = (hand[0].Get_Value() == hand[1].Get_Value() || hand[0].Get_Value()=="2" || hand[1].Get_Value()=="2") &&
				 (hand[1].Get_Value() == hand[2].Get_Value() || hand[1].Get_Value()=="2" || hand[2].Get_Value()=="2") &&
				 (hand[3].Get_Value() == hand[4].Get_Value() || hand[3].Get_Value() == "2");
				 
			a2 = (hand[0].Get_Value() == hand[1].Get_Value() || hand[0].Get_Value()=="2" || hand[1].Get_Value()=="2") &&
				 (hand[2].Get_Value() == hand[3].Get_Value() || hand[2].Get_Value()=="2" || hand[3].Get_Value()=="2") &&
				 (hand[3].Get_Value() == hand[4].Get_Value() || hand[3].Get_Value() == "2");
			return(a1 || a2);
		}
		
		//Checks for 4 of a kind
		//Sorts by value first, counts the number of two's
		//returns true if the number of two's is equal to 3, since you automatically have a 4 of a kind at that point
		//checks through possible combinations netting a 4 of a kind
		public function Check_4(hand:Array):Boolean
		{
			var a1:Boolean;
			var a2:Boolean;
			
			hand = Sort_Value(hand);
			var num_two:int = 0;
			for (var i:int = 0; i < 5; i++)
			{
				if (hand[i].Get_Value() == "2")
				{
					num_two++;
				}
			}
			
			if (num_two == 3)
			{
				return true;
			}else if(num_two == 2)
			{
				return(hand[2].Get_Value() == hand[3].Get_Value() || hand[3].Get_Value() == hand[4].Get_Value());
			}else if (num_two == 1)
			{
				a1 = hand[1].Get_Value() == hand[2].Get_Value() &&
				hand[2].Get_Value() == hand[3].Get_Value();
				
				a2 = hand[2].Get_Value() == hand[3].Get_Value() &&
				hand[3].Get_Value() == hand[4].Get_Value();
				return (a1 || a2);
			}else
			{			
			a1 = hand[0].Get_Value() == hand[1].Get_Value() &&
				hand[1].Get_Value() == hand[2].Get_Value() &&
				hand[2].Get_Value() == hand[3].Get_Value();
				
			a2 = hand[1].Get_Value() == hand[2].Get_Value() &&
				hand[2].Get_Value() == hand[3].Get_Value() &&
				hand[3].Get_Value() == hand[4].Get_Value();
			return(a1 || a2);
			}
		}
		
		//Checks for 5 of a kind
		//sorts by value
		//finds the first card that is not 2 and checks if it is the same as the last card. If it isn't return false, otherwise the loop will complete and return true
		public function Check_5(hand:Array):Boolean
		{			
			hand = Sort_Value(hand);
			for (var i:int = 0; i < 5; i++)
			{
				if (hand[i].Get_Value() != "2")
				{
					if (hand[i].Get_Value() != hand[4].Get_Value())
					{
						return false;
					}
				}
			}
			return true;			
		}
		
		//Checks 3 of a kind
		//sorts by value
		//counts the number of two's
		//if there are 2 two's you will have a three of a kind
		//if you have on two, check the possible combinations of a 3 of a kind
		//If you have no two's check possbile combinations of a 3 of a kind
		public function Check_3(hand:Array):Boolean
		{
			var a1:Boolean;
			var a2:Boolean;
			var a3:Boolean;
			
			hand = Sort_Value(hand);
			
			var num_two:int;
			
			for (var i:int = 0; i < 5; i++)
			{
				if (hand[i].Get_Value() == "2")
				{
					num_two++;
				}
			}
			
			if (num_two == 2)
			{
				return true;
			}
			else if (num_two == 1)
			{
				a1 = hand[1].Get_Value() == hand[2].Get_Value();
				a2 = hand[2].Get_Value() == hand[3].Get_Value();
				a3 = hand[3].Get_Value() == hand[4].Get_Value();
				return (a1 || a2 || a3);
			}
			else
			{			
				a1 = hand[0].Get_Value() == hand[1].Get_Value() &&
					 hand[1].Get_Value() == hand[2].Get_Value();
					 
				a2 = hand[1].Get_Value() == hand[2].Get_Value() &&
					 hand[2].Get_Value() == hand[3].Get_Value();
					 
				a3 = hand[2].Get_Value() == hand[3].Get_Value() &&
					 hand[3].Get_Value() == hand[4].Get_Value(); 
				return(a1 || a2 || a3);
			}
		}
		
		//Checks for flush
		//Sorts the hand by suit. Soring by suit also removes any two's from the hand
		//checks if the first and last card has the same suit. If they do you have a flush, if not then you don't
		//Removing two's allows us to simply check the first and last card, since a two can have any suit
		public function Check_Flush(hand:Array):Boolean
		{
			var Sorted_Hand = Sort_Suit(hand);
			var Hand_Size:int = Sorted_Hand.length-1;
			return(Sorted_Hand[0].Get_Suit() == Sorted_Hand[Hand_Size].Get_Suit());
		}
		
		//Checks for straight
		public function Check_Straight(hand:Array):Boolean
		{
			var Sorted_Hand = Sort_Value(hand);
			var i:int;
			var arrayPos:int;
			var Last_Num_Check:int
			var cardValue:String;
			//Possible straight combinations (not including wild 2s);
			var value:Array = new Array("14","2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14");
			var HighStraight:Array = new Array("10", "11", "12", "13", "14");
			
			//Check for the number of 2s in the hand
			var num_two:int;
			for (i = 0; i < 5; i++)
			{
				if (Sorted_Hand[i].Get_Value() == "2")
				{
					num_two++;
				}
			}
			
			//Check for the first card in the hand that is not a 2
			//Store the value of the card in a string variable "cardValue"
			for (i = 0; i < 5; i++)
			{
				if (Sorted_Hand[i].Get_Value() != "2")
				{
					cardValue = Sorted_Hand[i].Get_Value();
					break;
				}
			}
			
			//Check to see which position "cardValue" is stored in the array "value"
			//Store position in int variable "arrayPos"
			//"arrayPos" will determine the start of the for loop to check for a straight
			var valueLength:int = value.length;
			for (i = 0; i < valueLength; i++)
			{
				if (cardValue == value[i])
				{
					arrayPos = i;
					break;
				}
			}
			
			//This for loop checks for all straights except for a High Straight
			//"num_two_check" is used to ignore possible cards that break the straight due to wild 2s
			var j:int = 0;
			var num_two_check:int = num_two;
			var Straight:Boolean = true;
			Last_Num_Check = arrayPos;
			if (arrayPos+5>=14)
			{
				arrayPos = 9;
			}
			
			for (i = arrayPos; i < arrayPos + 5; i++)
			{
				//Since 2s should be at the start of the hand when sorted, we will check the position of the hand after the 2s
				//and compare this value to the current position in the "value" array.
				//If "num_two_check" is zero, then this means that there aren't enough 2s to fill in breaks in the straight
				if (j+num_two>=5)
				{
					break;
				}
				if (Sorted_Hand[j + num_two].Get_Value() != value[i] && num_two_check == 0)
				{
					Straight = false;
					break;
				}
				//If there is a discrepancy in the straight because of a wild 2, subtract the num_two_check variable
				//Subtract j so that we can check the discrepancy again with the next position
				if (Sorted_Hand[j + num_two].Get_Value() != value[i])
				{
					num_two_check--;
					j--;
				}
				j++;
			}
			
			//Return true if we find either a regular straight or a high straight
			return (Straight || Check_High_Straight(hand));
		}
		
		//Checks for a high straight
		//Helps us check for royal straight and regular straight by using it as a return condition for either
		//checks every card in the hand for cards that are a part of a high straight and only returns true if all are present
		public function Check_High_Straight(hand:Array):Boolean
		{
			var held = new Array(false, false, false, false, false);
			var check:int = 0;
			for (var i:int = 0; i < 5; i++)
			{
				if (hand[i].Get_Value() == "10" && held[0]==false)
				{
					held[0] = true;
					check++;
				}
				
				if (hand[i].Get_Value() == "J" && held[1]==false)
				{
					held[1] = true;
					check++;
				}
				
				if (hand[i].Get_Value() == "Q" && held[2]==false)
				{
					held[2] = true;
					check++;
				}
				
				if (hand[i].Get_Value() == "K" && held[3]==false)
				{
					held[3] = true;
					check++;
				}
				
				if (hand[i].Get_Value() == "A" && held[4]==false)
				{
					held[4] = true;
					check++;
				}
				
				if (hand[i].Get_Value() == "2")
				{
					check++;
				}
			}
			return(check==5);
		}
		
		public function Check_Straight_Flush(hand:Array):Boolean
		{
 			return (Check_Flush(hand) && Check_Straight(hand));
		}
		
		public function Check_Royal_Flush(hand:Array):Boolean
		{
			return (Check_High_Straight(hand) && Check_Flush(hand));
		}
		
		public function Sort_Suit(hand:Array):Array
		{
			var sortedHand = hand;
			var i:int;
			var j:int;
			var min_j:int;
			
			for (i = 0; i < 5; i++)
			{
				min_j = i;
				for (j = i + 1; j < 5; j++)
				{
					if (sortedHand[j].Get_Suit() < sortedHand[min_j].Get_Suit())
					{
						min_j = j;
					}
				}
				var Card_Help = sortedHand[i];
				sortedHand[i] = sortedHand[min_j];
				sortedHand[min_j] = Card_Help;
			}
			sortedHand = Remove_Two(sortedHand);
			return sortedHand;
		}
		
		public function Sort_Value(hand:Array):Array
		{
			var sortedHand = hand;
			var i:int;
			var j:int;
			var min_j:int;
			
			for (i = 0; i < 5; i++) 
			{
				if (sortedHand[i].Get_Value() == "J")
				{
					sortedHand[i].Set_Value("11");
				}
				else if (sortedHand[i].Get_Value() == "Q")
				{
					sortedHand[i].Set_Value("12");
				}
				else if (sortedHand[i].Get_Value() == "K")
				{
					sortedHand[i].Set_Value("13");
				}
				else if (sortedHand[i].Get_Value() == "A")
				{
					sortedHand[i].Set_Value("14");
				}
			}			
			
			for (i = 0; i < 5; i++)
			{
				min_j = i;
				
				for (j = i + 1; j < 5; j++)
				{
					if (int(sortedHand[j].Get_Value()) < int(sortedHand[min_j].Get_Value()))
					{
						min_j = j;
					}
				}
				
				var Card_Help = sortedHand[i];
				sortedHand[i] = sortedHand[min_j];
				sortedHand[min_j] = Card_Help;
			}
			return sortedHand;
		}
		
		public function Remove_Two(hand:Array):Array
		{
			var No_Two = new Array;
			var i:int;
			var card_num:int = 0;
			for (i = 0; i < 5; i++)
			{
				if (hand[i].Get_Value() != 2)
				{
					No_Two[card_num] = hand[i];
					card_num++;
				}
			}
			return No_Two;
		}
	}
}