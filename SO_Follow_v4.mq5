
void Sys_Follow_4_1(int callFrom)
{

    double top_level;
    double bottom_level;
    double sell_vol = SELECTED_VOLUME_LONG;
    double buy_vol = SELECTED_VOLUME_LONG;

    //Print("Sys_Follow_4_1 ",callFrom);
    
        if(MyGetVolumePosition() >= SELECTED_LIMIT_POSITION_VOLUME)
        {
            
            SO_FOLLOW_LOCK = 0;
            callFrom = 4;
        }
                
    
    if(SO_FOLLOW_LOCK == 0)
    {
        switch(callFrom) 
        {
            case 2:
                SetLevelRef(top_level, bottom_level);
                SO_FOLLOW_LOCK = 1;
                break;                                          
            case 3:
                top_level = DYT_SYMBOL_LAST_DEAL_PRICE;
                bottom_level = DYT_SYMBOL_LAST_DEAL_PRICE; 
                SO_FOLLOW_LOCK = 1;
                break; 
            case 4:
                CheckChangeLevel(top_level, bottom_level);
                SO_FOLLOW_LOCK = 1;
                break; 
        }

        SetLevelDistance(top_level, bottom_level, ESTRATEGIA_AJUSTE_DE_DISTANCIA);
        //Set_OrderVolume(sell_vol, buy_vol, ESTRATEGIA_AJUSTE_DE_VOLUME);
        Set_OrderVolume(ESTRATEGIA_AJUSTE_DE_VOLUME);

        SetAddChange(top_level, bottom_level);
        EN_BUY_MARKET_LEVEL = bottom_level;
        EN_SELL_MARKET_LEVEL = top_level;
    }
    Set_Market_Order_Trigger(FINAL_SHORT_VOLUME, FINAL_LONG_VOLUME );
}




void Sys_Follow_4_2(int callFrom)
{

    double top_level;
    double bottom_level;
    double sell_vol = SELECTED_VOLUME_LONG;
    double buy_vol = SELECTED_VOLUME_LONG;


    //Print("Sys_Follow_4_3 ",callFrom);


    if(SO_FOLLOW_LOCK == 0)
    {
        switch(callFrom) 
        {
            case 2:
                SetLevelRef(top_level, bottom_level);
                SO_FOLLOW_LOCK = 1;
                break;                                          
            case 3:
                top_level = DYT_SYMBOL_LAST_DEAL_PRICE;
                bottom_level = DYT_SYMBOL_LAST_DEAL_PRICE; 
                SO_FOLLOW_LOCK = 1;
                break; 
        }
        //SetLevelPlace(top_level, bottom_level);
        SetLevelDistance(top_level, bottom_level, ESTRATEGIA_AJUSTE_DE_DISTANCIA);
         //Set_OrderVolume(sell_vol, buy_vol, ESTRATEGIA_AJUSTE_DE_VOLUME);
        Set_OrderVolume(ESTRATEGIA_AJUSTE_DE_VOLUME);
        


        SetAddChange(top_level, bottom_level); // trabalhar na função em que a estratégia de add possa ser modificada (chosen est add)
        EN_BUY_MARKET_LEVEL = bottom_level;
        EN_SELL_MARKET_LEVEL = top_level;
    

    }

    Set_Market_Order_Trigger(FINAL_SHORT_VOLUME, FINAL_LONG_VOLUME );

}

