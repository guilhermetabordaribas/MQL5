#include <Trade\Trade.mqh>
CTrade trade;

void OnTick()
  {
      double ask, bid, last;
      double smaArray[];
      int smaHandle;
      
      ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
      bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);
      last = SymbolInfoDouble(_Symbol, SYMBOL_LAST);
      
      smaHandle = iMA(_Symbol, _Period, 20, 0, MODE_SMA, PRICE_CLOSE);
      ArraySetAsSeries(smaArray, true);
      CopyBuffer(smaHandle, 0, 0, 3, smaArray);
      
      if(last>smaArray[0] && PositionsTotal()==0)
         {
            Comment("Compra");
            trade.Buy(5, _Symbol, ask, ask-5, ask+5, "");
         }
      else if(last<smaArray[0] && PositionsTotal()==0)
         {
            Comment("Venda");
            trade.Sell(5, _Symbol, bid, bid+5, bid-5, ""); 
         }
   
  }
