#include <Trade\Trade.mqh>
CTrade trade;

double   ask, bid, last;
double   smaArray[];
int      smaHandle;

int OnInit()
  {
      smaHandle = iMA(_Symbol, _Period, 20, 0, MODE_SMA, PRICE_CLOSE);
      ArraySetAsSeries(smaArray, true);
      
      trade.SetTypeFilling(ORDER_FILLING_RETURN);
      trade.SetDeviationInPoints(50);
      trade.SetExpertMagicNumber(123456);
      
      return(INIT_SUCCEEDED);
  }

void OnTick()
  {    
      ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
      bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);
      last = SymbolInfoDouble(_Symbol, SYMBOL_LAST);
      
      CopyBuffer(smaHandle, 0, 0, 3, smaArray);
      
      if(last>smaArray[0] && PositionsTotal()==0)
         {
            //Comment("Compra");
            trade.Buy(5, _Symbol, ask, ask-5, ask+5, "");
         }
      else if(last<smaArray[0] && PositionsTotal()==0)
         {
            //Comment("Venda");
            trade.Sell(5, _Symbol, bid, bid+5, bid-5, ""); 
         }
   
  }
