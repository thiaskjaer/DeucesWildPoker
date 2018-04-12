package 
{
	import Card;
	/**
	 * ...
	 * @author Thias
	 */
	public class DECK 
	{
		private var New_Deck:Array;
		private var Suit:Array = new Array("H", "S", "D", "C");
		private var Value:Array = new Array("A","2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K");
		
		public function DECK()
		{
			
			
			New_Deck = new Array();
			
			for (var i:int = 0; i <= 3; i++)
			{
				for (var j:int = 0; j <= 12; j++)
				{
					var card:Card = new Card(Suit[i], Value[j]);
					New_Deck.push(card);
				}
			}
			
			this.New_Deck = Deck_Shuffler(New_Deck);
		}
		
		public function Deck_Deal():Card 
		{
			var top_card:Card = New_Deck[0];
			New_Deck.splice(0, 1);
			return top_card;
		}
		
		public function Deck_Shuffler(NewDeck:Array):Array 
		{
			var deck_init_copy:Array = NewDeck;
			var deck_shuffle_copy:Array = new Array();
			//try shuffle sort
			while (deck_init_copy.length > 0)
			{
				deck_shuffle_copy.push(deck_init_copy.splice(Math.round(Math.random() * (deck_init_copy.length - 1)), 1)[0]);
			}
			
			return deck_shuffle_copy;
		}
		
		public function Get_New_Deck():Array {
			return this.New_Deck;
		}
	}
}