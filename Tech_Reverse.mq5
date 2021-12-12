//+------------------------------------------------------------------+
//|                                                        Trend.mq5 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                                 https://mql5.com |
//+------------------------------------------------------------------+




void Set_Reverse(int chosen)
{
    switch(chosen)
    {
        case 1:
            EST_Reverse_01();
            break;            
        case 2:
            EST_Reverse_02();
            break;            
    }  
}



void EST_Reverse_01()
{
// trabalhar com volume e distância

    
    Level_Sell = Lowest_Top;
    Level_Buy = Highest_Bottom;

    Sell_Vol = SELECTED_VOLUME_SHORT ;
    Buy_Vol = SELECTED_VOLUME_LONG ;
    if(pos_status == 0)
    {
        Sell_Vol += pos_volume + SELECTED_VOLUME_SHORT;
        //Level_Sell = SERVER_SYMBOL_BID;
        Level_Sell = SERVER_SYMBOL_ASK;
    }
    if(pos_status == 1)
    {
        Buy_Vol += pos_volume + SELECTED_VOLUME_LONG;
        Level_Buy = SERVER_SYMBOL_BID;
        //Level_Buy = SERVER_SYMBOL_ASK;
    }

}
void EST_Reverse_02()
{
// trabalhar com volume e distância

    
    Level_Sell = Lowest_Top;
    Level_Buy = Highest_Bottom;

    Sell_Vol = SELECTED_VOLUME_SHORT ;
    Buy_Vol = SELECTED_VOLUME_LONG ;
    if(pos_status == 0)
    {
        Sell_Vol += SELECTED_VOLUME_SHORT;
        //Level_Sell = SERVER_SYMBOL_BID;
        Level_Sell = SERVER_SYMBOL_ASK;
    }
    if(pos_status == 1)
    {
        Buy_Vol +=  SELECTED_VOLUME_LONG;
        Level_Buy = SERVER_SYMBOL_BID;
        //Level_Buy = SERVER_SYMBOL_ASK;
    }

}
