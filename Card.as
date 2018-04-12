package 
{
	import DECK;
	/**
	 * ...
	 * @author Thias
	 */
	public class Card
	{
		public var Card_Suit:String;
		public var Card_Value:String;
		
		
		public function Card(_Suit:String, _Value:String) 
		{
			Card_Suit = _Suit;
			Card_Value = _Value;
		}
		
		public function Get_Suit():String
		{
			return this.Card_Suit;
		}
		
		public function Get_Value():String
		{
			return this.Card_Value;
		}
		
		public function Set_Suit(suit:String):void
		{
			this.Card_Suit = suit;
		}
		
		public function Set_Value(value:String):void
		{
			this.Card_Value = value;
		}
	}

}