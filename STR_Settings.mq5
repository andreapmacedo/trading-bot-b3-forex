

#include "STR_TrapBar.mq5"
#include "STR_BreakBar.mq5"

int SetOrderStrategy(int chosen)
{

    switch(chosen)
    {
        case 0:
            return 0;
            break;
        case 1:
            return ORD_Strategy_001();
            break;
        case 2:
            return ORD_Strategy_002();
            break;
        case 3:
            return ORD_Strategy_003();
            break;
        case 4:
            return ORD_Strategy_004();
            break;
        case 5:
            return ORD_Strategy_005();
            break;
        case 6:
            return ORD_Strategy_006();
            break;
        case 7:
            return ORD_Strategy_007();
            break;
        case 8:
            return ORD_Strategy_008();
            break;
        case 9:
            return ORD_Strategy_009();
            break;
        case 10:
            return ORD_Strategy_010();
            break;
        case 11:
            return ORD_Strategy_011();
            break;
        case 12:
            return ORD_Strategy_012();
            break;
        case 13:
            return ORD_Strategy_013();
            break;
        case 14:
            return ORD_Strategy_014();
            break;
        case 15:
            return ORD_Strategy_015();
            break;
        case 16:
            return ORD_Strategy_016();
            break;
        case 17:
            return ORD_Strategy_017();
            break;
        case 18:
            return ORD_Strategy_018();
            break;
        case 27:
            return ORD_Strategy_027();
            break;
        case 100:
            return ORD_Strategy_100();
            break;
        case 101:
            return ORD_Strategy_101();
            break;
        case 200:
            return ORD_Strategy_200();
        case 201:
            return ORD_Strategy_201();
            break;
    }
    return (0);
}


// 1 - subindo e comprado 
// 2 - subindo e vendido (revert)
// 3 - caindo e comprado (revert)
// 4 - caindo e vendido

//input double      EN_Distance_Long     = 25; // Valor - Distância - ENTRADA LONG
//input double      EN_Distance_Short    = 25; // Valor - Distância - ENTRADA SHORT

int ORD_Strategy_001()
{
    if(atualEstadoSinteticoDoTrade == 1) // a favor da tendência
    {        
        SetSisSettings_01();
    }
    else if(atualEstadoSinteticoDoTrade == 2) // contra a tendência
    {
        SetSisSettings_02();
    }
    
    else if(atualEstadoSinteticoDoTrade == 3) // contra a tendência na zona de transição
    {
        SetSisSettings_03();
    }
    else if(atualEstadoSinteticoDoTrade == 4) // não posicionado na zona de transição 
    {
        SetSisSettings_04();
    }
    else if(atualEstadoSinteticoDoTrade == 5) // não posicionado e sem tendência
    {
        SetSisSettings_05();
    }
    return 1;

}
int ORD_Strategy_002()
{
    // da pra mexer no min add e real pela estratégia quando for contra por exemplo
    // trabalhar o afastamento da média como parâmetro de entrada e saída de trade
    // so vender acima do PM (Ações)

	// CurrentTrend = Trend_Settings(SELECTED_EST_TREND_CHOSEN); // pode ser chamado do "time" routine para poupar recursos
	// atualEstadoDoTrade = estadoDoTrade(1);

    double temp_vol;
    definirVolumeAtualEmLoteOuUnidade(temp_vol);

    if(
        atualEstadoDoTrade == 1 // subindo e comprado
        )
    {
    //        definirDistanciaDoLevel_cfg_10();
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
        min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
        
        if(temp_vol > 2 && temp_vol < 4)
        {
            //Buy_Vol  = SELECTED_VOLUME_LONG * 2; // é mais agressivo para tendência
            Buy_Vol  = SELECTED_VOLUME_LONG;
        }
        else 
        {
            Buy_Vol  = SELECTED_VOLUME_LONG;
        }
        if(temp_vol > 4)
        {
            Sell_Vol  = SELECTED_VOLUME_SHORT * 2;
        }
        else
        {
            Sell_Vol  = SELECTED_VOLUME_SHORT ;
        }

    }
    else if(
            atualEstadoDoTrade == 2 // subindo e vendido
        ) 
    {
        // if(temp_vol <= 2 && pos_status == 1)
        // {
        //     Level_Buy = SERVER_SYMBOL_BID;
        //     Buy_Vol  = SELECTED_VOLUME_LONG * 2;
        //     Sell_Vol  = SELECTED_VOLUME_SHORT ;
        // }
        // if(pos_status == -1)
        // {
        // }
            
            if(TREND_CHANGED)
            {
                Level_Buy = SERVER_SYMBOL_BID;
            }
            else
            {
               distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
            }
            
            Buy_Vol  = SELECTED_VOLUME_LONG * 2;
            Sell_Vol  = SELECTED_VOLUME_SHORT ;

            


    }
    else if(
            atualEstadoDoTrade == 3 // caindo e comprado
        ) 
    {


            if(TREND_CHANGED)
            {
                Level_Sell = SERVER_SYMBOL_ASK;
            }
            else
            {

                distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
            }
            
            Buy_Vol  = SELECTED_VOLUME_LONG ;
            Sell_Vol  = SELECTED_VOLUME_SHORT * 2;


        // if(temp_vol <= 2 && pos_status == -1)
        // {        
        // }
        // if( pos_status == 1)
        // {        
        //     Level_Sell = SERVER_SYMBOL_ASK;
        //     Buy_Vol  = SELECTED_VOLUME_LONG ;
        //     Sell_Vol  = SELECTED_VOLUME_SHORT * 2;
        // }
    }
    else if(
            atualEstadoDoTrade == 4 // caindo e vendido
        ) 
    {
        //definirDistanciaDoLevel_cfg_10();
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
        min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;



        if(temp_vol > 2 && temp_vol < 4)
        {
            Sell_Vol  = SELECTED_VOLUME_SHORT ;
            //Sell_Vol  = SELECTED_VOLUME_SHORT ; //mais agressivo para tendência
        }
        else 
        {
            Sell_Vol  = SELECTED_VOLUME_SHORT ;
        }
        if(temp_vol > 4)
        {
            Buy_Vol  = SELECTED_VOLUME_LONG * 2;
        }
        else
        {
            Buy_Vol  = SELECTED_VOLUME_LONG;
        }
    }
    else if(
            atualEstadoDoTrade == 5 // zerado e subindo
        ) 
    {
        Buy_Vol  = SELECTED_VOLUME_LONG * 2;
    }
    else if(
            atualEstadoDoTrade == 6 // zerado e caindo
        ) 
    {
       Sell_Vol  = SELECTED_VOLUME_SHORT * 2;
    }
    return 1;
}

int ORD_Strategy_003()
{
    distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
    EN_OrderVolume_Settings(SELECTED_EST_VOLUME_CHOSEN);
    switch(atualEstadoSinteticoDoTrade)
    {
        case 1: // a favor da tendência
            SetSisSettings_01();
            break;
        case 2: // contra a tendência
            SetSisSettings_02();
            break;
        case 3: // contra a tendência na zona de transição
            SetSisSettings_03();
            break;
        case 4: // não posicionado na zona de transição 
            SetSisSettings_04();
            break;
        case 5: // não posicionado e sem tendência
            SetSisSettings_05();
            break;
        default:
            break;
    }
    return 1;
}
int ORD_Strategy_004()
{
    // da pra mexer no min add e real pela estratégia quando for contra por exemplo
    // trabalhar o afastamento da média como parâmetro de entrada e saída de trade
    // so vender acima do PM (Ações)

	// CurrentTrend = Trend_Settings(SELECTED_EST_TREND_CHOSEN); // pode ser chamado do "time" routine para poupar recursos
	// atualEstadoDoTrade = estadoDoTrade(1);

    double temp_vol;
    definirVolumeAtualEmLoteOuUnidade(temp_vol);

    if(
        atualEstadoDoTrade == 1 // subindo e comprado
        )
    {
    //        definirDistanciaDoLevel_cfg_10();
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        // min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
        // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
        
        if(temp_vol > 0 && temp_vol < 4)
        {
            //Buy_Vol  = SELECTED_VOLUME_LONG * 2; // é mais agressivo para tendência
            Buy_Vol  = SELECTED_VOLUME_LONG;
        }
        else 
        {
            Buy_Vol  = SELECTED_VOLUME_LONG;
        }
        if(temp_vol > 4)
        {
            Sell_Vol  = SELECTED_VOLUME_SHORT * 2;
        }
        else
        {
            Sell_Vol  = SELECTED_VOLUME_SHORT ;
        }
    }
    else if(
            atualEstadoDoTrade == 2 // subindo e vendido
        ) 
    {
        if(TREND_SIDE_CHANGED)
        {
            //Level_Buy = SERVER_SYMBOL_BID;
            Level_Buy = SERVER_SYMBOL_ASK;
            Buy_Vol  = (SELECTED_VOLUME_LONG * temp_vol);
        }
        else
        {
            distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
            Buy_Vol  = (SELECTED_VOLUME_LONG * 1);
        }
        
        Sell_Vol  = SELECTED_VOLUME_SHORT ;
    }
    else if(
            atualEstadoDoTrade == 3 // caindo e comprado
        ) 
    {
        if(TREND_SIDE_CHANGED)
        {
            //Level_Sell = SERVER_SYMBOL_ASK;
            Level_Sell = SERVER_SYMBOL_BID;
            Sell_Vol  = (SELECTED_VOLUME_SHORT * temp_vol);
        }
        else
        {

            distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
            Sell_Vol  = (SELECTED_VOLUME_SHORT * 1);
        }
        Buy_Vol  = SELECTED_VOLUME_LONG ;
    }
    else if(
            atualEstadoDoTrade == 4 // caindo e vendido
        ) 
    {
        //definirDistanciaDoLevel_cfg_10();
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        // min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
        // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;



        if(temp_vol > 0 && temp_vol < 4)
        {
            Sell_Vol  = SELECTED_VOLUME_SHORT ;
            //Sell_Vol  = SELECTED_VOLUME_SHORT ; //mais agressivo para tendência
        }
        else 
        {
            Sell_Vol  = SELECTED_VOLUME_SHORT ;
        }
        if(temp_vol > 4)
        {
            Buy_Vol  = SELECTED_VOLUME_LONG * 2;
        }
        else
        {
            Buy_Vol  = SELECTED_VOLUME_LONG;
        }
    }
    else if(
            atualEstadoDoTrade == 5 // zerado e subindo
        ) 
    {
        Buy_Vol  = SELECTED_VOLUME_LONG * 2;
       // CancelSellOrders(_Symbol, "trend down"); 
       // SELL_TREND_OK = false;
       // Level_Buy = SERVER_SYMBOL_BID;
        TopChange = SELECTED_EN_DISTANCE_SHORT * 4;
       
    }
    else if(
            atualEstadoDoTrade == 6 // zerado e caindo
        ) 
    {
       // CancelBuyOrders(_Symbol, "trend up"); 
       // BUY_TREND_OK = false;
       // Level_Sell = SERVER_SYMBOL_ASK;
       BottomChange = SELECTED_EN_DISTANCE_LONG * 4;
       Sell_Vol  = SELECTED_VOLUME_SHORT * 2;
    }
    return 1;
}
int ORD_Strategy_005()
{
    // da pra mexer no min add e real pela estratégia quando for contra por exemplo
    // trabalhar o afastamento da média como parâmetro de entrada e saída de trade
    // so vender acima do PM (Ações)

	// CurrentTrend = Trend_Settings(SELECTED_EST_TREND_CHOSEN); // pode ser chamado do "time" routine para poupar recursos
	// atualEstadoDoTrade = estadoDoTrade(1);

    double temp_vol;
    definirVolumeAtualEmLoteOuUnidade(temp_vol);



    if(
        atualEstadoDoTrade == 1 // subindo e comprado
        )
    {
    //        definirDistanciaDoLevel_cfg_10();
        // min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
        // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        if(temp_vol == 1)
        {
            TopChange += SELECTED_EN_DISTANCE_SHORT *2;
        }
        
        if(temp_vol > 0 && temp_vol < 4)
        {
            //Buy_Vol  = SELECTED_VOLUME_LONG * 2; // é mais agressivo para tendência
            Buy_Vol  = SELECTED_VOLUME_LONG;
        }
        else 
        {
            Buy_Vol  = SELECTED_VOLUME_LONG;
        }
        if(temp_vol > 4)
        {
            Sell_Vol  = SELECTED_VOLUME_SHORT * 2;
        }
        else
        {
            Sell_Vol  = SELECTED_VOLUME_SHORT ;
        }
    }
    else if(
            atualEstadoDoTrade == 2 // subindo e vendido
        ) 
    {
        //TopChange = SELECTED_EN_DISTANCE_SHORT * 4;
        Level_Buy = SERVER_SYMBOL_ASK;
        Buy_Vol  = (SELECTED_VOLUME_LONG * temp_vol);
        Sell_Vol  = SELECTED_VOLUME_SHORT ;
        SELL_TREND_OK = false;
        // if(TREND_SIDE_CHANGED)
        // {
        //     //Level_Buy = SERVER_SYMBOL_BID;
        // }
        // else
        // {
        //     distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        //     Buy_Vol  = (SELECTED_VOLUME_LONG * 1);
        // }
        
    }
    else if(
            atualEstadoDoTrade == 3 // caindo e comprado
        ) 
    {
 //            Level_Buy = SERVER_SYMBOL_ASK;
        //BottomChange = SELECTED_EN_DISTANCE_LONG * 4;
        Level_Sell = SERVER_SYMBOL_BID;
        Sell_Vol  = (SELECTED_VOLUME_SHORT * temp_vol);
        Buy_Vol  = SELECTED_VOLUME_LONG ;
        BUY_TREND_OK = false;

        // if(TREND_SIDE_CHANGED)
        // {
        //     //Level_Sell = SERVER_SYMBOL_ASK;
        // }
        // else
        // {

        //     //distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        //    // Sell_Vol  = (SELECTED_VOLUME_SHORT * 1);
        // }
    }
    else if(
            atualEstadoDoTrade == 4 // caindo e vendido
        ) 
    {
        //definirDistanciaDoLevel_cfg_10();
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        // min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
        // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
        if(temp_vol == 1)
        {
            BottomChange += SELECTED_EN_DISTANCE_LONG * 2;
        }


        if(temp_vol > 0 && temp_vol < 4)
        {
            Sell_Vol  = SELECTED_VOLUME_SHORT ;
            //Sell_Vol  = SELECTED_VOLUME_SHORT ; //mais agressivo para tendência
        }
        else 
        {
            Sell_Vol  = SELECTED_VOLUME_SHORT ;
        }
        if(temp_vol > 4)
        {
            Buy_Vol  = SELECTED_VOLUME_LONG * 2;
        }
        else
        {
            Buy_Vol  = SELECTED_VOLUME_LONG;
        }
    }
    else if(
            atualEstadoDoTrade == 5 // zerado e subindo
        ) 
    {
       
        Buy_Vol  = SELECTED_VOLUME_LONG * 2;
        Sell_Vol  = SELECTED_VOLUME_SHORT;
       // CancelSellOrders(_Symbol, "trend down"); 
        SELL_TREND_OK = false;
       // Level_Buy = SERVER_SYMBOL_BID;
        //TopChange = SELECTED_EN_DISTANCE_SHORT * 4;
       
    }
    else if(
            atualEstadoDoTrade == 6 // zerado e caindo
        ) 
    {
       // CancelBuyOrders(_Symbol, "trend up"); 
       
        BUY_TREND_OK = false;
       // Level_Sell = SERVER_SYMBOL_ASK;
       Buy_Vol  = SELECTED_VOLUME_LONG;
       //BottomChange = SELECTED_EN_DISTANCE_LONG * 4;
       Sell_Vol  = SELECTED_VOLUME_SHORT * 2;
    }
    else if(
            atualEstadoDoTrade == 7 // neutro e comprado
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        Buy_Vol  = SELECTED_VOLUME_LONG;
        Sell_Vol  = SELECTED_VOLUME_SHORT;
    }
    else if(
            atualEstadoDoTrade == 8 // zerado e caindo
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        Buy_Vol  = SELECTED_VOLUME_LONG;
        Sell_Vol  = SELECTED_VOLUME_SHORT;
    }
    else if(
            atualEstadoDoTrade == 9 // zerado e neutro
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        Buy_Vol  = SELECTED_VOLUME_LONG;
        Sell_Vol  = SELECTED_VOLUME_SHORT;
    }
    return 1;
}
int ORD_Strategy_006()
{
    // da pra mexer no min add e real pela estratégia quando for contra por exemplo
    // trabalhar o afastamento da média como parâmetro de entrada e saída de trade
    // so vender acima do PM (Ações)

	// CurrentTrend = Trend_Settings(SELECTED_EST_TREND_CHOSEN); // pode ser chamado do "time" routine para poupar recursos
	// atualEstadoDoTrade = estadoDoTrade(1);

    double temp_vol;
    definirVolumeAtualEmLoteOuUnidade(temp_vol);

    if(
        atualEstadoDoTrade == 1 // subindo e comprado
        )
    {
    //        definirDistanciaDoLevel_cfg_10();
        // min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
        // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        if(temp_vol == 1)
        {
            TopChange += SELECTED_EN_DISTANCE_SHORT *2;
        }
        
        if(temp_vol > 0 && temp_vol < 4)
        {
            //Buy_Vol  = SELECTED_VOLUME_LONG * 2; // é mais agressivo para tendência
            Buy_Vol  = SELECTED_VOLUME_LONG;
        }
        else 
        {
            Buy_Vol  = SELECTED_VOLUME_LONG;
        }
        if(temp_vol > 4)
        {
            Sell_Vol  = SELECTED_VOLUME_SHORT * 2;
        }
        else
        {
            Sell_Vol  = SELECTED_VOLUME_SHORT ;
        }
    }
    else if(
            atualEstadoDoTrade == 2 // subindo e vendido
        ) 
    {
       // TopChange = SELECTED_EN_DISTANCE_SHORT * 4;
        Level_Buy = SERVER_SYMBOL_ASK;
        Buy_Vol  = (SELECTED_VOLUME_LONG * temp_vol);
        Sell_Vol  = SELECTED_VOLUME_SHORT ;
        //SELL_TREND_OK = false;
        // if(TREND_SIDE_CHANGED)
        // {
        //     //Level_Buy = SERVER_SYMBOL_BID;
        // }
        // else
        // {
        //     distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        //     Buy_Vol  = (SELECTED_VOLUME_LONG * 1);
        // }
        
    }
    else if(
            atualEstadoDoTrade == 3 // caindo e comprado
        ) 
    {
 //            Level_Buy = SERVER_SYMBOL_ASK;
       // BottomChange = SELECTED_EN_DISTANCE_LONG * 4;
        Level_Sell = SERVER_SYMBOL_BID;
        Sell_Vol  = (SELECTED_VOLUME_SHORT * temp_vol);
        Buy_Vol  = SELECTED_VOLUME_LONG ;
        //BUY_TREND_OK = false;

        // if(TREND_SIDE_CHANGED)
        // {
        //     //Level_Sell = SERVER_SYMBOL_ASK;
        // }
        // else
        // {

        //     //distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        //    // Sell_Vol  = (SELECTED_VOLUME_SHORT * 1);
        // }
    }
    else if(
            atualEstadoDoTrade == 4 // caindo e vendido
        ) 
    {
        //definirDistanciaDoLevel_cfg_10();
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        // min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
        // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
        if(temp_vol == 1)
        {
            BottomChange += SELECTED_EN_DISTANCE_LONG * 2;
        }


        if(temp_vol > 0 && temp_vol < 4)
        {
            Sell_Vol  = SELECTED_VOLUME_SHORT ;
            //Sell_Vol  = SELECTED_VOLUME_SHORT ; //mais agressivo para tendência
        }
        else 
        {
            Sell_Vol  = SELECTED_VOLUME_SHORT ;
        }
        if(temp_vol > 4)
        {
            Buy_Vol  = SELECTED_VOLUME_LONG * 2;
        }
        else
        {
            Buy_Vol  = SELECTED_VOLUME_LONG;
        }
    }
    else if(
            atualEstadoDoTrade == 5 // zerado e subindo
        ) 
    {
       
        Buy_Vol  = SELECTED_VOLUME_LONG * 2;
        Sell_Vol  = SELECTED_VOLUME_SHORT;
       // CancelSellOrders(_Symbol, "trend down"); 
        //SELL_TREND_OK = false;
        //Level_Buy = SERVER_SYMBOL_BID;
        Level_Buy = SERVER_SYMBOL_ASK;
       // TopChange = SELECTED_EN_DISTANCE_SHORT * 4;
       
    }
    else if(
            atualEstadoDoTrade == 6 // zerado e caindo
        ) 
    {
       // CancelBuyOrders(_Symbol, "trend up"); 
       
       // BUY_TREND_OK = false;
       //Level_Sell = SERVER_SYMBOL_ASK;
       Level_Sell = SERVER_SYMBOL_BID;
       Buy_Vol  = SELECTED_VOLUME_LONG;
       //BottomChange = SELECTED_EN_DISTANCE_LONG * 4;
       Sell_Vol  = SELECTED_VOLUME_SHORT * 2;
    }
    else if(
            atualEstadoDoTrade == 7 // neutro e comprado
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        Buy_Vol  = SELECTED_VOLUME_LONG;
        Sell_Vol  = SELECTED_VOLUME_SHORT;
    }
    else if(
            atualEstadoDoTrade == 8 // zerado e caindo
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        Buy_Vol  = SELECTED_VOLUME_LONG;
        Sell_Vol  = SELECTED_VOLUME_SHORT;
    }
    else if(
            atualEstadoDoTrade == 9 // zerado e neutro
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        Buy_Vol  = SELECTED_VOLUME_LONG;
        Sell_Vol  = SELECTED_VOLUME_SHORT;
    }
    return 1;
}
int ORD_Strategy_007()
{
    // da pra mexer no min add e real pela estratégia quando for contra por exemplo
    // trabalhar o afastamento da média como parâmetro de entrada e saída de trade
    // so vender acima do PM (Ações)

	// CurrentTrend = Trend_Settings(SELECTED_EST_TREND_CHOSEN); // pode ser chamado do "time" routine para poupar recursos
	// atualEstadoDoTrade = estadoDoTrade(1);

    double temp_vol;
    definirVolumeAtualEmLoteOuUnidade(temp_vol);

    if(
        atualEstadoDoTrade == 1 // subindo e comprado
        )
    {
    
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
        min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
        
        if(temp_vol > 2 && temp_vol < 4)
        {
            //Buy_Vol  = SELECTED_VOLUME_LONG * 2; // é mais agressivo para tendência
            Buy_Vol  = SELECTED_VOLUME_LONG;
        }
        else 
        {
            Buy_Vol  = SELECTED_VOLUME_LONG;
        }
        if(temp_vol > 4)
        {
            Sell_Vol  = SELECTED_VOLUME_SHORT * 2;
        }
        else
        {
            Sell_Vol  = SELECTED_VOLUME_SHORT ;
        }

    }
    else if(
            atualEstadoDoTrade == 2 // subindo e vendido
        ) 
    {
        //if(TREND_CHANGED)
        if(TREND_SIDE_CHANGED)
        {
            Level_Buy = SERVER_SYMBOL_BID;
        }
        else
        {
            distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        }
        Buy_Vol  = SELECTED_VOLUME_LONG * 2;
        Sell_Vol  = SELECTED_VOLUME_SHORT ;
    }
    else if(
            atualEstadoDoTrade == 3 // caindo e comprado
        ) 
    {
        //if(TREND_CHANGED)
        if(TREND_SIDE_CHANGED)
        {
            Level_Sell = SERVER_SYMBOL_ASK;
        }
        else
        {
            distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        }
        
        Buy_Vol  = SELECTED_VOLUME_LONG ;
        Sell_Vol  = SELECTED_VOLUME_SHORT * 2;
    }
    else if(
            atualEstadoDoTrade == 4 // caindo e vendido
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
        min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;

        if(temp_vol > 2 && temp_vol < 4)
        {
            Sell_Vol  = SELECTED_VOLUME_SHORT ;
            //Sell_Vol  = SELECTED_VOLUME_SHORT ; //mais agressivo para tendência
        }
        else 
        {
            Sell_Vol  = SELECTED_VOLUME_SHORT ;
        }
        if(temp_vol > 4)
        {
            Buy_Vol  = SELECTED_VOLUME_LONG * 2;
        }
        else
        {
            Buy_Vol  = SELECTED_VOLUME_LONG;
        }
    }
    else if(
            atualEstadoDoTrade == 5 // zerado e subindo
        ) 
    {
        Buy_Vol  = SELECTED_VOLUME_LONG * 2;
    }
    else if(
            atualEstadoDoTrade == 6 // zerado e caindo
        ) 
    {
       Sell_Vol  = SELECTED_VOLUME_SHORT * 2;
    }
    else
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        Buy_Vol  = SELECTED_VOLUME_LONG;
        Sell_Vol  = SELECTED_VOLUME_SHORT;
    }
    return 1;
}
int ORD_Strategy_008()
{
    // da pra mexer no min add e real pela estratégia quando for contra por exemplo
    // trabalhar o afastamento da média como parâmetro de entrada e saída de trade
    // so vender acima do PM (Ações)

	// CurrentTrend = Trend_Settings(SELECTED_EST_TREND_CHOSEN); // pode ser chamado do "time" routine para poupar recursos
	// atualEstadoDoTrade = estadoDoTrade(1);

    double temp_vol;
    definirVolumeAtualEmLoteOuUnidade(temp_vol);

    if(
        atualEstadoDoTrade == 1 // subindo e comprado
        )
    {
    
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
        min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
        
        if(temp_vol > 2 && temp_vol < 4)
        {
            //Buy_Vol  = SELECTED_VOLUME_LONG * 2; // é mais agressivo para tendência
            Buy_Vol  = SELECTED_VOLUME_LONG;
        }
        else 
        {
            Buy_Vol  = SELECTED_VOLUME_LONG;
        }
        if(temp_vol > 4)
        {
            Sell_Vol  = SELECTED_VOLUME_SHORT * 2;
        }
        else
        {
            Sell_Vol  = SELECTED_VOLUME_SHORT ;
        }

    }
    else if(
            atualEstadoDoTrade == 2 // subindo e vendido
        ) 
    {
        
        if(TREND_SIDE_CHANGED)
        {
            Level_Buy = SERVER_SYMBOL_BID;
            //ResetAxlesLevels();
            //CountFreezeCentralLevel == 0;
        }
        else
        {
            distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        }
        Buy_Vol  = SELECTED_VOLUME_LONG * 2;
        Sell_Vol  = SELECTED_VOLUME_SHORT ;
    }
    else if(
            atualEstadoDoTrade == 3 // caindo e comprado
        ) 
    {
        //if(TREND_CHANGED)
        if(TREND_SIDE_CHANGED)
        {
            Level_Sell = SERVER_SYMBOL_ASK;
            //ResetAxlesLevels();
            //CountFreezeCentralLevel == 0;
        }
        else
        {
            distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        }
        
        Buy_Vol  = SELECTED_VOLUME_LONG ;
        Sell_Vol  = SELECTED_VOLUME_SHORT * 2;
    }
    else if(
            atualEstadoDoTrade == 4 // caindo e vendido
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
        min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;

        if(temp_vol > 2 && temp_vol < 4)
        {
            Sell_Vol  = SELECTED_VOLUME_SHORT ;
            //Sell_Vol  = SELECTED_VOLUME_SHORT ; //mais agressivo para tendência
        }
        else 
        {
            Sell_Vol  = SELECTED_VOLUME_SHORT ;
        }
        if(temp_vol > 4)
        {
            Buy_Vol  = SELECTED_VOLUME_LONG * 2;
        }
        else
        {
            Buy_Vol  = SELECTED_VOLUME_LONG;
        }
    }
    else if(
            atualEstadoDoTrade == 5 // zerado e subindo
        ) 
    {
        Buy_Vol  = SELECTED_VOLUME_LONG * 2;
    }
    else if(
            atualEstadoDoTrade == 6 // zerado e caindo
        ) 
    {
       Sell_Vol  = SELECTED_VOLUME_SHORT * 2;
    }
    else
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        Buy_Vol  = SELECTED_VOLUME_LONG;
        Sell_Vol  = SELECTED_VOLUME_SHORT;
    }
    return 1;
}
int ORD_Strategy_009()
{
    // da pra mexer no min add e real pela estratégia quando for contra por exemplo
    // trabalhar o afastamento da média como parâmetro de entrada e saída de trade
    // so vender acima do PM (Ações)

	// CurrentTrend = Trend_Settings(SELECTED_EST_TREND_CHOSEN); // pode ser chamado do "time" routine para poupar recursos
	// atualEstadoDoTrade = estadoDoTrade(1);

    double temp_vol;
    definirVolumeAtualEmLoteOuUnidade(temp_vol);

    if(
        atualEstadoDoTrade == 1 // subindo e comprado
        )
    {
    
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
        min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
        
        if(temp_vol > 2 && temp_vol < 4)
        {
            //Buy_Vol  = SELECTED_VOLUME_LONG * 2; // é mais agressivo para tendência
            Buy_Vol  = SELECTED_VOLUME_LONG;
        }
        else 
        {
            Buy_Vol  = SELECTED_VOLUME_LONG;
        }
        if(temp_vol > 4)
        {
            Sell_Vol  = SELECTED_VOLUME_SHORT * 2;
        }
        else
        {
            Sell_Vol  = SELECTED_VOLUME_SHORT ;
        }

    }
    else if(
            atualEstadoDoTrade == 2 // subindo e vendido
        ) 
    {
        
        // if(TREND_SIDE_CHANGED)
        // {
        //     //ResetAxlesLevels();
        //     //CountFreezeCentralLevel == 0;
        // }
        // else
        // {
        // }
        Level_Buy = SERVER_SYMBOL_BID;
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        BottomChange = 0;
        
        Buy_Vol  = SELECTED_VOLUME_LONG * 2;
        Sell_Vol  = SELECTED_VOLUME_SHORT ;
    }
    else if(
            atualEstadoDoTrade == 3 // caindo e comprado
        ) 
    {

        // if(TREND_SIDE_CHANGED)
        // {
        //     //ResetAxlesLevels();
        //     //CountFreezeCentralLevel == 0;
        // }
        // else
        // {
        // }
        Level_Sell = SERVER_SYMBOL_ASK;
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        TopChange = 0;
        Buy_Vol  = SELECTED_VOLUME_LONG ;
        Sell_Vol  = SELECTED_VOLUME_SHORT * 2;
    }
    else if(
            atualEstadoDoTrade == 4 // caindo e vendido
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
        min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;

        if(temp_vol > 2 && temp_vol < 4)
        {
            Sell_Vol  = SELECTED_VOLUME_SHORT ;
            //Sell_Vol  = SELECTED_VOLUME_SHORT ; //mais agressivo para tendência
        }
        else 
        {
            Sell_Vol  = SELECTED_VOLUME_SHORT ;
        }
        if(temp_vol > 4)
        {
            Buy_Vol  = SELECTED_VOLUME_LONG * 2;
        }
        else
        {
            Buy_Vol  = SELECTED_VOLUME_LONG;
        }
    }
    else if(
            atualEstadoDoTrade == 5 // zerado e subindo
        ) 
    {
        Buy_Vol  = SELECTED_VOLUME_LONG * 2;
    }
    else if(
            atualEstadoDoTrade == 6 // zerado e caindo
        ) 
    {
       Sell_Vol  = SELECTED_VOLUME_SHORT * 2;
    }
    else
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        Buy_Vol  = SELECTED_VOLUME_LONG;
        Sell_Vol  = SELECTED_VOLUME_SHORT;
    }
    return 1;
}
int ORD_Strategy_010()
{
    double temp_vol;
    definirVolumeAtualEmLoteOuUnidade(temp_vol);

    if(
        atualEstadoDoTrade == 1 // subindo e comprado
        )
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        //min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
       // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
        if(temp_vol > 2 && temp_vol < 4)
        {
            //Buy_Vol  = SELECTED_VOLUME_LONG * 2; // é mais agressivo para tendência
            Buy_Vol  = SELECTED_VOLUME_LONG;
        }
        else 
        {
            Buy_Vol  = SELECTED_VOLUME_LONG;
        }
        if(temp_vol > 4)
        {
            Sell_Vol  = SELECTED_VOLUME_SHORT * 2;
        }
        else
        {
            Sell_Vol  = SELECTED_VOLUME_SHORT ;
        }

    }
    else if(
            atualEstadoDoTrade == 2 // subindo e vendido
        ) 
    {
        
        // if(TREND_SIDE_CHANGED)
        // {
        //     //ResetAxlesLevels();
        //     //CountFreezeCentralLevel == 0;
        // }
        // else
        // {
        // }
        Level_Buy = SERVER_SYMBOL_BID;
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        //BottomChange = 0;
        
        Buy_Vol  = SELECTED_VOLUME_LONG * 2;
        Sell_Vol  = SELECTED_VOLUME_SHORT ;
    }
    else if(
            atualEstadoDoTrade == 3 // caindo e comprado
        ) 
    {

        // if(TREND_SIDE_CHANGED)
        // {
        //     //ResetAxlesLevels();
        //     //CountFreezeCentralLevel == 0;
        // }
        // else
        // {
        // }
        Level_Sell = SERVER_SYMBOL_ASK;
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        //TopChange = 0;
        Buy_Vol  = SELECTED_VOLUME_LONG ;
        Sell_Vol  = SELECTED_VOLUME_SHORT * 2;
    }
    else if(
            atualEstadoDoTrade == 4 // caindo e vendido
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        //min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
       // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;

        if(temp_vol > 2 && temp_vol < 4)
        {
            Sell_Vol  = SELECTED_VOLUME_SHORT ;
            //Sell_Vol  = SELECTED_VOLUME_SHORT ; //mais agressivo para tendência
        }
        else 
        {
            Sell_Vol  = SELECTED_VOLUME_SHORT ;
        }
        if(temp_vol > 4)
        {
            Buy_Vol  = SELECTED_VOLUME_LONG * 2;
        }
        else
        {
            Buy_Vol  = SELECTED_VOLUME_LONG;
        }
    }
    else if(
            atualEstadoDoTrade == 5 // zerado e subindo
        ) 
    {
        Buy_Vol  = SELECTED_VOLUME_LONG * 2;
    }
    else if(
            atualEstadoDoTrade == 6 // zerado e caindo
        ) 
    {
       Sell_Vol  = SELECTED_VOLUME_SHORT * 2;
    }
    else
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        Buy_Vol  = SELECTED_VOLUME_LONG;
        Sell_Vol  = SELECTED_VOLUME_SHORT;
    }
    return 1;
}

int ORD_Strategy_011()
{
    double temp_vol;
    definirVolumeAtualEmLoteOuUnidade(temp_vol);

    if(
        atualEstadoSinteticoDoTrade == 1 // a favor da tendência
        )
    {        
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
      
        //min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
       // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
       // if(temp_vol == 1)
        // {
        //         // em uma estratégia que visa a tendência, o ideal é increementar a distância para o lado oposto da posição quando o volume for 1

            if(pos_status == 0) // comprado
            {
                //TopChange += 200;
                //if(SERVER_SYMBOL_BID > (Freeze_Central_Top + SELECTED_EN_DISTANCE_LONG))
                // if(spd > SELECTED_EN_DISTANCE_LONG)
                // {
                //     Level_Buy = SERVER_SYMBOL_BID;
                // }
                //Buy_Vol = SELECTED_VOLUME_LONG * 2;
                BuyVolChange += SELECTED_VOLUME_LONG ;
             

            }
            else // vendido
            {

                //Sell_Vol = SELECTED_VOLUME_SHORT * 2;
                SellVolChange += SELECTED_VOLUME_SHORT ;
                //if(SERVER_SYMBOL_ASK < ( Freeze_Central_Bottom- SELECTED_EN_DISTANCE_SHORT))
                    //Level_Sell = SERVER_SYMBOL_ASK;
                // if(spd > SELECTED_EN_DISTANCE_SHORT)
                // {
                // }                
                //BottomChange += 200;
            }

        // }
        // else if(temp_vol > 2 && temp_vol < 4)
        // {
        //     if(pos_status == 0) // comprado
        //     {

        //     }
        //     else // vendido
        //     {
        //     }

        // }
        if(temp_vol > 3)
        {
           if(pos_status == 0) // comprado
            {
                Sell_Vol = SELECTED_VOLUME_SHORT * 2;
            }
            else // vendido
            {
                
                Buy_Vol = SELECTED_VOLUME_LONG * 2;
            }
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 2 // contra a tendência
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        
        

        if(pos_status == 0) // comprado
        {
                //Central_Top = SERVER_SYMBOL_LAST;
            
            //SetTopMagneticMovie();

            if(sequenciaDeEntradaNivelInferior > 0)
            {
                Sell_Vol = SELECTED_VOLUME_SHORT * 2;

            }
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            
            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_ASK <  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG))
            //     {
            //         //Level_Sell = Freeze_Central_Bottom; 
                    
            //         Level_Sell = SERVER_SYMBOL_ASK; 
            //         Sell_Vol = SELECTED_VOLUME_SHORT ;
            //     }
            // }

        }
        else // vendido
        {

            //SetBottomMagneticMovie();
            if(sequenciaDeEntradaNivelSuperior > 0)
            {
                Buy_Vol = SELECTED_VOLUME_LONG * 2;
            }

            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_BID >  (Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT))
            //     {
                    
            //         //Level_Buy = Freeze_Central_Top;  
                    
            //         Level_Buy = SERVER_SYMBOL_BID; 
            //         Buy_Vol = SELECTED_VOLUME_LONG ;
            //     }
            // }

            //BuyVolChange  += SELECTED_VOLUME_LONG;
            //Buy_Vol  = temp_vol; // exemplo de possibilidade
            //Buy_Vol  = temp_vol/2; // exemplo de possibilidade
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 3 // contra a tendência na zona de transição
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        if(pos_status == 0) // comprado
        {
            //Level_Sell = (Freeze_Central_Top - SELECTED_EN_DISTANCE_SHORT);
            
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            //BottomChange = 0;

        }
        else // vendido
        {
            
            //Level_Buy =  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            //BuyVolChange  += SELECTED_VOLUME_LONG;
           // TopChange += 50;
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 4 // não posicionado na zona de transição
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    else // não posicionado e sem tendência
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    return 1;
}
int ORD_Strategy_021()
{
    double temp_vol;
    definirVolumeAtualEmLoteOuUnidade(temp_vol);

    if(
        atualEstadoSinteticoDoTrade == 1 // a favor da tendência
        )
    {        
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
      
        //min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
       // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
       // if(temp_vol == 1)
        // {
        //         // em uma estratégia que visa a tendência, o ideal é increementar a distância para o lado oposto da posição quando o volume for 1

            if(pos_status == 0) // comprado
            {
                //TopChange += 200;
                //if(SERVER_SYMBOL_BID > (Freeze_Central_Top + SELECTED_EN_DISTANCE_LONG))
                // if(spd > SELECTED_EN_DISTANCE_LONG)
                // {
                //     Level_Buy = SERVER_SYMBOL_BID;
                // }
                //Buy_Vol = SELECTED_VOLUME_LONG * 2;
                BuyVolChange += SELECTED_VOLUME_LONG ;
             

            }
            else // vendido
            {

                //Sell_Vol = SELECTED_VOLUME_SHORT * 2;
                SellVolChange += SELECTED_VOLUME_SHORT ;
                //if(SERVER_SYMBOL_ASK < ( Freeze_Central_Bottom- SELECTED_EN_DISTANCE_SHORT))
                    //Level_Sell = SERVER_SYMBOL_ASK;
                // if(spd > SELECTED_EN_DISTANCE_SHORT)
                // {
                // }                
                //BottomChange += 200;
            }

        // }
        // else if(temp_vol > 2 && temp_vol < 4)
        // {
        //     if(pos_status == 0) // comprado
        //     {

        //     }
        //     else // vendido
        //     {
        //     }

        // }
        if(temp_vol > 3)
        {
           if(pos_status == 0) // comprado
            {
                Sell_Vol = SELECTED_VOLUME_SHORT * 2;
            }
            else // vendido
            {
                
                Buy_Vol = SELECTED_VOLUME_LONG * 2;
            }
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 2 // contra a tendência
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        
        
        if(pos_status == 0) // comprado
        {
                //Central_Top = SERVER_SYMBOL_LAST;
            
            SetTopMagneticMovie(); // (est 2x)

            if(sequenciaDeEntradaNivelInferior > 0)
            {
                Sell_Vol = SELECTED_VOLUME_SHORT * 2;

            }
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            
            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_ASK <  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG))
            //     {
            //         //Level_Sell = Freeze_Central_Bottom; 
                    
            //         Level_Sell = SERVER_SYMBOL_ASK; 
            //         Sell_Vol = SELECTED_VOLUME_SHORT ;
            //     }
            // }

        }
        else // vendido
        {

            SetBottomMagneticMovie(); // (est 2x)
            if(sequenciaDeEntradaNivelSuperior > 0)
            {
                Buy_Vol = SELECTED_VOLUME_LONG * 2;
            }

            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_BID >  (Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT))
            //     {
                    
            //         //Level_Buy = Freeze_Central_Top;  
                    
            //         Level_Buy = SERVER_SYMBOL_BID; 
            //         Buy_Vol = SELECTED_VOLUME_LONG ;
            //     }
            // }

            //BuyVolChange  += SELECTED_VOLUME_LONG;
            //Buy_Vol  = temp_vol; // exemplo de possibilidade
            //Buy_Vol  = temp_vol/2; // exemplo de possibilidade
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 3 // contra a tendência na zona de transição
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        if(pos_status == 0) // comprado
        {
            //Level_Sell = (Freeze_Central_Top - SELECTED_EN_DISTANCE_SHORT);
            
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            //BottomChange = 0;

        }
        else // vendido
        {
            
            //Level_Buy =  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            //BuyVolChange  += SELECTED_VOLUME_LONG;
           // TopChange += 50;
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 4 // não posicionado na zona de transição
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    else // não posicionado e sem tendência
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    return 1;
}


int ORD_Strategy_012()
{
    double temp_vol;
    definirVolumeAtualEmLoteOuUnidade(temp_vol);
    distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);

    if(
        atualEstadoSinteticoDoTrade == 1 // a favor da tendência
        )
    {        
       // elaborar uma estratégia de diatância que altera a distancia de acordo com o atualEstadoSinteticoDoTrade
       // elaborar uma estratégia de volume que altera a distancia de acordo com o atualEstadoSinteticoDoTrade
       
        //min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
       // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
       // if(temp_vol == 1)
        // {
        //         // em uma estratégia que visa a tendência, o ideal é increementar a distância para o lado oposto da posição quando o volume for 1

            if(pos_status == 0) // comprado
            {
                //TopChange += 200;
                //if(SERVER_SYMBOL_BID > (Freeze_Central_Top + SELECTED_EN_DISTANCE_LONG))
                // if(spd > SELECTED_EN_DISTANCE_LONG)
                // {
                //     Level_Buy = SERVER_SYMBOL_BID;
                // }
                //Buy_Vol = SELECTED_VOLUME_LONG * 2;
                BuyVolChange += SELECTED_VOLUME_LONG ;
             

            }
            else // vendido
            {

                //Sell_Vol = SELECTED_VOLUME_SHORT * 2;
                SellVolChange += SELECTED_VOLUME_SHORT ;
                //if(SERVER_SYMBOL_ASK < ( Freeze_Central_Bottom- SELECTED_EN_DISTANCE_SHORT))
                    //Level_Sell = SERVER_SYMBOL_ASK;
                // if(spd > SELECTED_EN_DISTANCE_SHORT)
                // {
                // }                
                //BottomChange += 200;
            }

        // }
        // else if(temp_vol > 2 && temp_vol < 4)
        // {
        //     if(pos_status == 0) // comprado
        //     {

        //     }
        //     else // vendido
        //     {
        //     }

        // }
        if(temp_vol > 3)
        {
           if(pos_status == 0) // comprado
            {
                Sell_Vol = SELECTED_VOLUME_SHORT * 2;
            }
            else // vendido
            {
                
                Buy_Vol = SELECTED_VOLUME_LONG * 2;
            }
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 2 // contra a tendência
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        if(pos_status == 0) // comprado
        {
           // if(sequenciaDeEntradaNivelInferior > 0)
                Sell_Vol = SELECTED_VOLUME_SHORT * 2;
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            
            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_ASK <  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG))
            //     {
            //         //Level_Sell = Freeze_Central_Bottom; 
                    
            //         Level_Sell = SERVER_SYMBOL_ASK; 
            //         Sell_Vol = SELECTED_VOLUME_SHORT ;
            //     }
            // }

        }
        else // vendido
        {
            //Level_Buy = (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
           // if(sequenciaDeEntradaNivelSuperior > 0)
            Buy_Vol = SELECTED_VOLUME_LONG * 2;

            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_BID >  (Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT))
            //     {
                    
            //         //Level_Buy = Freeze_Central_Top;  
                    
            //         Level_Buy = SERVER_SYMBOL_BID; 
            //         Buy_Vol = SELECTED_VOLUME_LONG ;
            //     }
            // }

            //BuyVolChange  += SELECTED_VOLUME_LONG;
            //Buy_Vol  = temp_vol; // exemplo de possibilidade
            //Buy_Vol  = temp_vol/2; // exemplo de possibilidade
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 3 // contra a tendência na zona de transição
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        if(pos_status == 0) // comprado
        {
            //Level_Sell = (Freeze_Central_Top - SELECTED_EN_DISTANCE_SHORT);
            
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            //BottomChange = 0;

        }
        else // vendido
        {
            
            //Level_Buy =  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            //BuyVolChange  += SELECTED_VOLUME_LONG;
           // TopChange += 50;
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 4 // não posicionado na zona de transição
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    else // não posicionado e sem tendência
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    return 1;
}
int ORD_Strategy_022()
{
    double temp_vol;
    definirVolumeAtualEmLoteOuUnidade(temp_vol);
    distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);

    if(
        atualEstadoSinteticoDoTrade == 1 // a favor da tendência
        )
    {        
       // elaborar uma estratégia de diatância que altera a distancia de acordo com o atualEstadoSinteticoDoTrade
       // elaborar uma estratégia de volume que altera a distancia de acordo com o atualEstadoSinteticoDoTrade
       
        //min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
       // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
       // if(temp_vol == 1)
        // {
        //         // em uma estratégia que visa a tendência, o ideal é increementar a distância para o lado oposto da posição quando o volume for 1

            if(pos_status == 0) // comprado
            {
                //TopChange += 200;
                //if(SERVER_SYMBOL_BID > (Freeze_Central_Top + SELECTED_EN_DISTANCE_LONG))
                // if(spd > SELECTED_EN_DISTANCE_LONG)
                // {
                //     Level_Buy = SERVER_SYMBOL_BID;
                // }
                //Buy_Vol = SELECTED_VOLUME_LONG * 2;
                BuyVolChange += SELECTED_VOLUME_LONG ;
             

            }
            else // vendido
            {

                //Sell_Vol = SELECTED_VOLUME_SHORT * 2;
                SellVolChange += SELECTED_VOLUME_SHORT ;
                //if(SERVER_SYMBOL_ASK < ( Freeze_Central_Bottom- SELECTED_EN_DISTANCE_SHORT))
                    //Level_Sell = SERVER_SYMBOL_ASK;
                // if(spd > SELECTED_EN_DISTANCE_SHORT)
                // {
                // }                
                //BottomChange += 200;
            }

        // }
        // else if(temp_vol > 2 && temp_vol < 4)
        // {
        //     if(pos_status == 0) // comprado
        //     {

        //     }
        //     else // vendido
        //     {
        //     }

        // }
        if(temp_vol > 3)
        {
           if(pos_status == 0) // comprado
            {
                Sell_Vol = SELECTED_VOLUME_SHORT * 2;
            }
            else // vendido
            {
                
                Buy_Vol = SELECTED_VOLUME_LONG * 2;
            }
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 2 // contra a tendência
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        if(pos_status == 0) // comprado
        {
           // if(sequenciaDeEntradaNivelInferior > 0)
            SetTopMagneticMovie(); // (est 21)
            Sell_Vol = SELECTED_VOLUME_SHORT * 2;
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            
            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_ASK <  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG))
            //     {
            //         //Level_Sell = Freeze_Central_Bottom; 
                    
            //         Level_Sell = SERVER_SYMBOL_ASK; 
            //         Sell_Vol = SELECTED_VOLUME_SHORT ;
            //     }
            // }

        }
        else // vendido
        {
            //Level_Buy = (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
           // if(sequenciaDeEntradaNivelSuperior > 0)
            SetBottomMagneticMovie(); // (est 21)
            Buy_Vol = SELECTED_VOLUME_LONG * 2;

            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_BID >  (Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT))
            //     {
                    
            //         //Level_Buy = Freeze_Central_Top;  
                    
            //         Level_Buy = SERVER_SYMBOL_BID; 
            //         Buy_Vol = SELECTED_VOLUME_LONG ;
            //     }
            // }

            //BuyVolChange  += SELECTED_VOLUME_LONG;
            //Buy_Vol  = temp_vol; // exemplo de possibilidade
            //Buy_Vol  = temp_vol/2; // exemplo de possibilidade
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 3 // contra a tendência na zona de transição
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        if(pos_status == 0) // comprado
        {
            //Level_Sell = (Freeze_Central_Top - SELECTED_EN_DISTANCE_SHORT);
            
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            //BottomChange = 0;

        }
        else // vendido
        {
            
            //Level_Buy =  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            //BuyVolChange  += SELECTED_VOLUME_LONG;
           // TopChange += 50;
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 4 // não posicionado na zona de transição
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    else // não posicionado e sem tendência
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    return 1;
}

int ORD_Strategy_013()
{
    double temp_vol;
    definirVolumeAtualEmLoteOuUnidade(temp_vol);
    distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);

    if(
        atualEstadoSinteticoDoTrade == 1 // a favor da tendência
        )
    {        
       // elaborar uma estratégia de diatância que altera a distancia de acordo com o atualEstadoSinteticoDoTrade
       // elaborar uma estratégia de volume que altera a distancia de acordo com o atualEstadoSinteticoDoTrade
       
        //min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
       // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
       // if(temp_vol == 1)
        // {
        //         // em uma estratégia que visa a tendência, o ideal é increementar a distância para o lado oposto da posição quando o volume for 1

            if(pos_status == 0) // comprado
            {
                //TopChange += 200;
                //if(SERVER_SYMBOL_BID > (Freeze_Central_Top + SELECTED_EN_DISTANCE_LONG))
                // if(spd > SELECTED_EN_DISTANCE_LONG)
                // {
                //     Level_Buy = SERVER_SYMBOL_BID;
                // }
                //Buy_Vol = SELECTED_VOLUME_LONG * 2;
                BuyVolChange += SELECTED_VOLUME_LONG ;
             

            }
            else // vendido
            {

                //Sell_Vol = SELECTED_VOLUME_SHORT * 2;
                SellVolChange += SELECTED_VOLUME_SHORT ;
                //if(SERVER_SYMBOL_ASK < ( Freeze_Central_Bottom- SELECTED_EN_DISTANCE_SHORT))
                    //Level_Sell = SERVER_SYMBOL_ASK;
                // if(spd > SELECTED_EN_DISTANCE_SHORT)
                // {
                // }                
                //BottomChange += 200;
            }

        // }
        // else if(temp_vol > 2 && temp_vol < 4)
        // {
        //     if(pos_status == 0) // comprado
        //     {

        //     }
        //     else // vendido
        //     {
        //     }

        // }
        if(temp_vol > 3)
        {
           if(pos_status == 0) // comprado
            {
                Sell_Vol = SELECTED_VOLUME_SHORT * 2;
            }
            else // vendido
            {
                
                Buy_Vol = SELECTED_VOLUME_LONG * 2;
            }
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 2 // contra a tendência
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        if(pos_status == 0) // comprado
        {
            if(sequenciaDeEntradaNivelInferior > 0)
                Sell_Vol = SELECTED_VOLUME_SHORT * 3;
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            
            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_ASK <  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG))
            //     {
            //         //Level_Sell = Freeze_Central_Bottom; 
                    
            //         Level_Sell = SERVER_SYMBOL_ASK; 
            //         Sell_Vol = SELECTED_VOLUME_SHORT ;
            //     }
            // }

        }
        else // vendido
        {
            //Level_Buy = (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            if(sequenciaDeEntradaNivelSuperior > 0)
                Buy_Vol = SELECTED_VOLUME_LONG * 3;

            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_BID >  (Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT))
            //     {
                    
            //         //Level_Buy = Freeze_Central_Top;  
                    
            //         Level_Buy = SERVER_SYMBOL_BID; 
            //         Buy_Vol = SELECTED_VOLUME_LONG ;
            //     }
            // }

            //BuyVolChange  += SELECTED_VOLUME_LONG;
            //Buy_Vol  = temp_vol; // exemplo de possibilidade
            //Buy_Vol  = temp_vol/2; // exemplo de possibilidade
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 3 // contra a tendência na zona de transição
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        if(pos_status == 0) // comprado
        {
            //Level_Sell = (Freeze_Central_Top - SELECTED_EN_DISTANCE_SHORT);
            
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            //BottomChange = 0;

        }
        else // vendido
        {
            
            //Level_Buy =  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            //BuyVolChange  += SELECTED_VOLUME_LONG;
           // TopChange += 50;
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 4 // não posicionado na zona de transição
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    else // não posicionado e sem tendência
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    return 1;
}

int ORD_Strategy_023()
{
    double temp_vol;
    definirVolumeAtualEmLoteOuUnidade(temp_vol);
    distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);

    if(
        atualEstadoSinteticoDoTrade == 1 // a favor da tendência
        )
    {        
       // elaborar uma estratégia de diatância que altera a distancia de acordo com o atualEstadoSinteticoDoTrade
       // elaborar uma estratégia de volume que altera a distancia de acordo com o atualEstadoSinteticoDoTrade
       
        //min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
       // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
       // if(temp_vol == 1)
        // {
        //         // em uma estratégia que visa a tendência, o ideal é increementar a distância para o lado oposto da posição quando o volume for 1

            if(pos_status == 0) // comprado
            {
                //TopChange += 200;
                //if(SERVER_SYMBOL_BID > (Freeze_Central_Top + SELECTED_EN_DISTANCE_LONG))
                // if(spd > SELECTED_EN_DISTANCE_LONG)
                // {
                //     Level_Buy = SERVER_SYMBOL_BID;
                // }
                //Buy_Vol = SELECTED_VOLUME_LONG * 2;
                BuyVolChange += SELECTED_VOLUME_LONG ;
             

            }
            else // vendido
            {

                //Sell_Vol = SELECTED_VOLUME_SHORT * 2;
                SellVolChange += SELECTED_VOLUME_SHORT ;
                //if(SERVER_SYMBOL_ASK < ( Freeze_Central_Bottom- SELECTED_EN_DISTANCE_SHORT))
                    //Level_Sell = SERVER_SYMBOL_ASK;
                // if(spd > SELECTED_EN_DISTANCE_SHORT)
                // {
                // }                
                //BottomChange += 200;
            }

        // }
        // else if(temp_vol > 2 && temp_vol < 4)
        // {
        //     if(pos_status == 0) // comprado
        //     {

        //     }
        //     else // vendido
        //     {
        //     }

        // }
        if(temp_vol > 3)
        {
           if(pos_status == 0) // comprado
            {
                Sell_Vol = SELECTED_VOLUME_SHORT * 2;
            }
            else // vendido
            {
                
                Buy_Vol = SELECTED_VOLUME_LONG * 2;
            }
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 2 // contra a tendência
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        if(pos_status == 0) // comprado
        {
            SetTopMagneticMovie(); // (est 2x)
            if(sequenciaDeEntradaNivelInferior > 0)
                Sell_Vol = SELECTED_VOLUME_SHORT * 3;
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            
            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_ASK <  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG))
            //     {
            //         //Level_Sell = Freeze_Central_Bottom; 
                    
            //         Level_Sell = SERVER_SYMBOL_ASK; 
            //         Sell_Vol = SELECTED_VOLUME_SHORT ;
            //     }
            // }

        }
        else // vendido
        {
            //Level_Buy = (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            SetBottomMagneticMovie(); // (est 2x)
            if(sequenciaDeEntradaNivelSuperior > 0)
                Buy_Vol = SELECTED_VOLUME_LONG * 3;

            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_BID >  (Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT))
            //     {
                    
            //         //Level_Buy = Freeze_Central_Top;  
                    
            //         Level_Buy = SERVER_SYMBOL_BID; 
            //         Buy_Vol = SELECTED_VOLUME_LONG ;
            //     }
            // }

            //BuyVolChange  += SELECTED_VOLUME_LONG;
            //Buy_Vol  = temp_vol; // exemplo de possibilidade
            //Buy_Vol  = temp_vol/2; // exemplo de possibilidade
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 3 // contra a tendência na zona de transição
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        if(pos_status == 0) // comprado
        {
            //Level_Sell = (Freeze_Central_Top - SELECTED_EN_DISTANCE_SHORT);
            
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            //BottomChange = 0;

        }
        else // vendido
        {
            
            //Level_Buy =  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            //BuyVolChange  += SELECTED_VOLUME_LONG;
           // TopChange += 50;
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 4 // não posicionado na zona de transição
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    else // não posicionado e sem tendência
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    return 1;
}

int ORD_Strategy_014()
{
    double temp_vol;
    definirVolumeAtualEmLoteOuUnidade(temp_vol);
    distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);

    if(
        atualEstadoSinteticoDoTrade == 1 // a favor da tendência
        )
    {        
       // elaborar uma estratégia de diatância que altera a distancia de acordo com o atualEstadoSinteticoDoTrade
       // elaborar uma estratégia de volume que altera a distancia de acordo com o atualEstadoSinteticoDoTrade
       
        //min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
       // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
       // if(temp_vol == 1)
        // {
        //         // em uma estratégia que visa a tendência, o ideal é increementar a distância para o lado oposto da posição quando o volume for 1

            if(pos_status == 0) // comprado
            {
                //TopChange += 200;
                //if(SERVER_SYMBOL_BID > (Freeze_Central_Top + SELECTED_EN_DISTANCE_LONG))
                // if(spd > SELECTED_EN_DISTANCE_LONG)
                // {
                //     Level_Buy = SERVER_SYMBOL_BID;
                // }
                //Buy_Vol = SELECTED_VOLUME_LONG * 2;
                BuyVolChange += SELECTED_VOLUME_LONG ;
             

            }
            else // vendido
            {

                //Sell_Vol = SELECTED_VOLUME_SHORT * 2;
                SellVolChange += SELECTED_VOLUME_SHORT ;
                //if(SERVER_SYMBOL_ASK < ( Freeze_Central_Bottom- SELECTED_EN_DISTANCE_SHORT))
                    //Level_Sell = SERVER_SYMBOL_ASK;
                // if(spd > SELECTED_EN_DISTANCE_SHORT)
                // {
                // }                
                //BottomChange += 200;
            }

        // }
        // else if(temp_vol > 2 && temp_vol < 4)
        // {
        //     if(pos_status == 0) // comprado
        //     {

        //     }
        //     else // vendido
        //     {
        //     }

        // }
        if(temp_vol > 3)
        {
           if(pos_status == 0) // comprado
            {
                Sell_Vol = SELECTED_VOLUME_SHORT * 2;
            }
            else // vendido
            {
                
                Buy_Vol = SELECTED_VOLUME_LONG * 2;
            }
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 2 // contra a tendência
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        if(pos_status == 0) // comprado
        {
            if(sequenciaDeEntradaNivelInferior > 0)
                Sell_Vol = SELECTED_VOLUME_SHORT * 3;
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            
            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_ASK <  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG))
            //     {
            //         //Level_Sell = Freeze_Central_Bottom; 
                    
            //         Level_Sell = SERVER_SYMBOL_ASK; 
            //         Sell_Vol = SELECTED_VOLUME_SHORT ;
            //     }
            // }

        }
        else // vendido
        {
            //Level_Buy = (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            if(sequenciaDeEntradaNivelSuperior > 0)
            Buy_Vol = SELECTED_VOLUME_LONG * 3;

            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_BID >  (Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT))
            //     {
                    
            //         //Level_Buy = Freeze_Central_Top;  
                    
            //         Level_Buy = SERVER_SYMBOL_BID; 
            //         Buy_Vol = SELECTED_VOLUME_LONG ;
            //     }
            // }

            //BuyVolChange  += SELECTED_VOLUME_LONG;
            //Buy_Vol  = temp_vol; // exemplo de possibilidade
            //Buy_Vol  = temp_vol/2; // exemplo de possibilidade
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 3 // contra a tendência na zona de transição
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        if(pos_status == 0) // comprado
        {
            if(sequenciaDeEntradaNivelInferior > 0)
                Sell_Vol = SELECTED_VOLUME_SHORT * 2;
            //Level_Sell = (Freeze_Central_Top - SELECTED_EN_DISTANCE_SHORT);
            
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            //BottomChange = 0;

        }
        else // vendido
        {
            if(sequenciaDeEntradaNivelSuperior > 0)
                Buy_Vol = SELECTED_VOLUME_LONG * 2;
            
            //Level_Buy =  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            //BuyVolChange  += SELECTED_VOLUME_LONG;
           // TopChange += 50;
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 4 // não posicionado na zona de transição
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    else // não posicionado e sem tendência
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    return 1;
}

int ORD_Strategy_024()
{
    double temp_vol;
    definirVolumeAtualEmLoteOuUnidade(temp_vol);
    distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);

    if(
        atualEstadoSinteticoDoTrade == 1 // a favor da tendência
        )
    {        
       // elaborar uma estratégia de diatância que altera a distancia de acordo com o atualEstadoSinteticoDoTrade
       // elaborar uma estratégia de volume que altera a distancia de acordo com o atualEstadoSinteticoDoTrade
       
        //min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
       // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
       // if(temp_vol == 1)
        // {
        //         // em uma estratégia que visa a tendência, o ideal é increementar a distância para o lado oposto da posição quando o volume for 1

            if(pos_status == 0) // comprado
            {
                //TopChange += 200;
                //if(SERVER_SYMBOL_BID > (Freeze_Central_Top + SELECTED_EN_DISTANCE_LONG))
                // if(spd > SELECTED_EN_DISTANCE_LONG)
                // {
                //     Level_Buy = SERVER_SYMBOL_BID;
                // }
                //Buy_Vol = SELECTED_VOLUME_LONG * 2;
                BuyVolChange += SELECTED_VOLUME_LONG ;
             

            }
            else // vendido
            {

                //Sell_Vol = SELECTED_VOLUME_SHORT * 2;
                SellVolChange += SELECTED_VOLUME_SHORT ;
                //if(SERVER_SYMBOL_ASK < ( Freeze_Central_Bottom- SELECTED_EN_DISTANCE_SHORT))
                    //Level_Sell = SERVER_SYMBOL_ASK;
                // if(spd > SELECTED_EN_DISTANCE_SHORT)
                // {
                // }                
                //BottomChange += 200;
            }

        // }
        // else if(temp_vol > 2 && temp_vol < 4)
        // {
        //     if(pos_status == 0) // comprado
        //     {

        //     }
        //     else // vendido
        //     {
        //     }

        // }
        if(temp_vol > 3)
        {
           if(pos_status == 0) // comprado
            {
                Sell_Vol = SELECTED_VOLUME_SHORT * 2;
            }
            else // vendido
            {
                
                Buy_Vol = SELECTED_VOLUME_LONG * 2;
            }
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 2 // contra a tendência
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        if(pos_status == 0) // comprado
        {
            SetTopMagneticMovie(); // (est 2x)
            if(sequenciaDeEntradaNivelInferior > 0)
                Sell_Vol = SELECTED_VOLUME_SHORT * 3;
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            
            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_ASK <  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG))
            //     {
            //         //Level_Sell = Freeze_Central_Bottom; 
                    
            //         Level_Sell = SERVER_SYMBOL_ASK; 
            //         Sell_Vol = SELECTED_VOLUME_SHORT ;
            //     }
            // }

        }
        else // vendido
        {
            //Level_Buy = (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);

            SetBottomMagneticMovie(); // (est 2x)
            if(sequenciaDeEntradaNivelSuperior > 0)
            Buy_Vol = SELECTED_VOLUME_LONG * 3;

            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_BID >  (Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT))
            //     {
                    
            //         //Level_Buy = Freeze_Central_Top;  
                    
            //         Level_Buy = SERVER_SYMBOL_BID; 
            //         Buy_Vol = SELECTED_VOLUME_LONG ;
            //     }
            // }

            //BuyVolChange  += SELECTED_VOLUME_LONG;
            //Buy_Vol  = temp_vol; // exemplo de possibilidade
            //Buy_Vol  = temp_vol/2; // exemplo de possibilidade
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 3 // contra a tendência na zona de transição
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        if(pos_status == 0) // comprado
        {
            if(sequenciaDeEntradaNivelInferior > 0)
                Sell_Vol = SELECTED_VOLUME_SHORT * 2;
            //Level_Sell = (Freeze_Central_Top - SELECTED_EN_DISTANCE_SHORT);
            
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            //BottomChange = 0;

        }
        else // vendido
        {
            if(sequenciaDeEntradaNivelSuperior > 0)
                Buy_Vol = SELECTED_VOLUME_LONG * 2;
            
            //Level_Buy =  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            //BuyVolChange  += SELECTED_VOLUME_LONG;
           // TopChange += 50;
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 4 // não posicionado na zona de transição
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    else // não posicionado e sem tendência
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    return 1;
}

int ORD_Strategy_015()
{
    double temp_vol;
    definirVolumeAtualEmLoteOuUnidade(temp_vol);
    distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);

    if(
        atualEstadoSinteticoDoTrade == 1 // a favor da tendência
        )
    {        
       // elaborar uma estratégia de diatância que altera a distancia de acordo com o atualEstadoSinteticoDoTrade
       // elaborar uma estratégia de volume que altera a distancia de acordo com o atualEstadoSinteticoDoTrade
       
        //min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
       // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
       // if(temp_vol == 1)
        // {
        //         // em uma estratégia que visa a tendência, o ideal é increementar a distância para o lado oposto da posição quando o volume for 1

            if(pos_status == 0) // comprado
            {
                //TopChange += 200;
                //if(SERVER_SYMBOL_BID > (Freeze_Central_Top + SELECTED_EN_DISTANCE_LONG))
                // if(spd > SELECTED_EN_DISTANCE_LONG)
                // {
                //     Level_Buy = SERVER_SYMBOL_BID;
                // }
                //Buy_Vol = SELECTED_VOLUME_LONG * 2;
                BuyVolChange += SELECTED_VOLUME_LONG ;
             

            }
            else // vendido
            {

                //Sell_Vol = SELECTED_VOLUME_SHORT * 2;
                SellVolChange += SELECTED_VOLUME_SHORT ;
                //if(SERVER_SYMBOL_ASK < ( Freeze_Central_Bottom- SELECTED_EN_DISTANCE_SHORT))
                    //Level_Sell = SERVER_SYMBOL_ASK;
                // if(spd > SELECTED_EN_DISTANCE_SHORT)
                // {
                // }                
                //BottomChange += 200;
            }

        // }
        // else if(temp_vol > 2 && temp_vol < 4)
        // {
        //     if(pos_status == 0) // comprado
        //     {

        //     }
        //     else // vendido
        //     {
        //     }

        // }
        if(temp_vol > 3)
        {
           if(pos_status == 0) // comprado
            {
                Sell_Vol = SELECTED_VOLUME_SHORT * 2;
            }
            else // vendido
            {
                
                Buy_Vol = SELECTED_VOLUME_LONG * 2;
            }
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 2 // contra a tendência
        ) 
    {
        if(pos_status == 0) // comprado
        {
            if(sequenciaDeEntradaNivelInferior > 0)
                Sell_Vol = SELECTED_VOLUME_SHORT * 3;
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            
            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_ASK <  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG))
            //     {
            //         //Level_Sell = Freeze_Central_Bottom; 
                    
            //         Level_Sell = SERVER_SYMBOL_ASK; 
            //         Sell_Vol = SELECTED_VOLUME_SHORT ;
            //     }
            // }

        }
        else
        {
            distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        }

        if(pos_status == 1) // vendido
        {
            //Level_Buy = (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            if(sequenciaDeEntradaNivelSuperior > 0)
            Buy_Vol = SELECTED_VOLUME_LONG * 3;

            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_BID >  (Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT))
            //     {
                    
            //         //Level_Buy = Freeze_Central_Top;  
                    
            //         Level_Buy = SERVER_SYMBOL_BID; 
            //         Buy_Vol = SELECTED_VOLUME_LONG ;
            //     }
            // }

            //BuyVolChange  += SELECTED_VOLUME_LONG;
            //Buy_Vol  = temp_vol; // exemplo de possibilidade
            //Buy_Vol  = temp_vol/2; // exemplo de possibilidade
        }
        else
        {
            distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 3 // contra a tendência na zona de transição
        ) 
    {
        if(pos_status == 0) // comprado
        {
            if(sequenciaDeEntradaNivelInferior > 0)
                Sell_Vol = SELECTED_VOLUME_SHORT * 2;
            //Level_Sell = (Freeze_Central_Top - SELECTED_EN_DISTANCE_SHORT);
            
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            //BottomChange = 0;

        }
        else // vendido
        {
            distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        }
        if(pos_status == 1) // vendido
        {
            if(sequenciaDeEntradaNivelSuperior > 0)
                Buy_Vol = SELECTED_VOLUME_LONG * 2;
            
            //Level_Buy =  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            //BuyVolChange  += SELECTED_VOLUME_LONG;
           // TopChange += 50;
        }
        else
        {
            distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 4 // não posicionado na zona de transição
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    else // não posicionado e sem tendência
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    return 1;
}

int ORD_Strategy_025()
{
    double temp_vol;
    definirVolumeAtualEmLoteOuUnidade(temp_vol);
    distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);

    if(
        atualEstadoSinteticoDoTrade == 1 // a favor da tendência
        )
    {        
       // elaborar uma estratégia de diatância que altera a distancia de acordo com o atualEstadoSinteticoDoTrade
       // elaborar uma estratégia de volume que altera a distancia de acordo com o atualEstadoSinteticoDoTrade
       
        //min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
       // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
       // if(temp_vol == 1)
        // {
        //         // em uma estratégia que visa a tendência, o ideal é increementar a distância para o lado oposto da posição quando o volume for 1

            if(pos_status == 0) // comprado
            {
                //TopChange += 200;
                //if(SERVER_SYMBOL_BID > (Freeze_Central_Top + SELECTED_EN_DISTANCE_LONG))
                // if(spd > SELECTED_EN_DISTANCE_LONG)
                // {
                //     Level_Buy = SERVER_SYMBOL_BID;
                // }
                //Buy_Vol = SELECTED_VOLUME_LONG * 2;
                BuyVolChange += SELECTED_VOLUME_LONG ;
             

            }
            else // vendido
            {

                //Sell_Vol = SELECTED_VOLUME_SHORT * 2;
                SellVolChange += SELECTED_VOLUME_SHORT ;
                //if(SERVER_SYMBOL_ASK < ( Freeze_Central_Bottom- SELECTED_EN_DISTANCE_SHORT))
                    //Level_Sell = SERVER_SYMBOL_ASK;
                // if(spd > SELECTED_EN_DISTANCE_SHORT)
                // {
                // }                
                //BottomChange += 200;
            }

        // }
        // else if(temp_vol > 2 && temp_vol < 4)
        // {
        //     if(pos_status == 0) // comprado
        //     {

        //     }
        //     else // vendido
        //     {
        //     }

        // }
        if(temp_vol > 3)
        {
           if(pos_status == 0) // comprado
            {
                Sell_Vol = SELECTED_VOLUME_SHORT * 2;
            }
            else // vendido
            {
                
                Buy_Vol = SELECTED_VOLUME_LONG * 2;
            }
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 2 // contra a tendência
        ) 
    {
        SetTopMagneticMovie(); // (est 2x)
        if(pos_status == 0) // comprado
        {
            if(sequenciaDeEntradaNivelInferior > 0)
                Sell_Vol = SELECTED_VOLUME_SHORT * 3;
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            
            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_ASK <  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG))
            //     {
            //         //Level_Sell = Freeze_Central_Bottom; 
                    
            //         Level_Sell = SERVER_SYMBOL_ASK; 
            //         Sell_Vol = SELECTED_VOLUME_SHORT ;
            //     }
            // }

        }
        else
        {
            distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        }

        if(pos_status == 1) // vendido
        {
            SetBottomMagneticMovie(); // (est 2x)
            //Level_Buy = (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            if(sequenciaDeEntradaNivelSuperior > 0)
            Buy_Vol = SELECTED_VOLUME_LONG * 3;

            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_BID >  (Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT))
            //     {
                    
            //         //Level_Buy = Freeze_Central_Top;  
                    
            //         Level_Buy = SERVER_SYMBOL_BID; 
            //         Buy_Vol = SELECTED_VOLUME_LONG ;
            //     }
            // }

            //BuyVolChange  += SELECTED_VOLUME_LONG;
            //Buy_Vol  = temp_vol; // exemplo de possibilidade
            //Buy_Vol  = temp_vol/2; // exemplo de possibilidade
        }
        else
        {
            distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 3 // contra a tendência na zona de transição
        ) 
    {
        if(pos_status == 0) // comprado
        {
            if(sequenciaDeEntradaNivelInferior > 0)
                Sell_Vol = SELECTED_VOLUME_SHORT * 2;
            //Level_Sell = (Freeze_Central_Top - SELECTED_EN_DISTANCE_SHORT);
            
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            //BottomChange = 0;

        }
        else // vendido
        {
            distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        }
        if(pos_status == 1) // vendido
        {
            if(sequenciaDeEntradaNivelSuperior > 0)
                Buy_Vol = SELECTED_VOLUME_LONG * 2;
            
            //Level_Buy =  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            //BuyVolChange  += SELECTED_VOLUME_LONG;
           // TopChange += 50;
        }
        else
        {
            distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 4 // não posicionado na zona de transição
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    else // não posicionado e sem tendência
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    return 1;
}

int ORD_Strategy_016()
{
    double temp_vol;
    definirVolumeAtualEmLoteOuUnidade(temp_vol);
    distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);

    if(
        atualEstadoSinteticoDoTrade == 1 // a favor da tendência
        )
    {        
       // elaborar uma estratégia de diatância que altera a distancia de acordo com o atualEstadoSinteticoDoTrade
       // elaborar uma estratégia de volume que altera a distancia de acordo com o atualEstadoSinteticoDoTrade
       
        //min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
       // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
       // if(temp_vol == 1)
        // {
        //         // em uma estratégia que visa a tendência, o ideal é increementar a distância para o lado oposto da posição quando o volume for 1

            if(pos_status == 0) // comprado
            {
                //TopChange += 200;
                //if(SERVER_SYMBOL_BID > (Freeze_Central_Top + SELECTED_EN_DISTANCE_LONG))
                // if(spd > SELECTED_EN_DISTANCE_LONG)
                // {
                //     Level_Buy = SERVER_SYMBOL_BID;
                // }
                //Buy_Vol = SELECTED_VOLUME_LONG * 2;
                BuyVolChange += SELECTED_VOLUME_LONG ;
             

            }
            else // vendido
            {

                //Sell_Vol = SELECTED_VOLUME_SHORT * 2;
                SellVolChange += SELECTED_VOLUME_SHORT ;
                //if(SERVER_SYMBOL_ASK < ( Freeze_Central_Bottom- SELECTED_EN_DISTANCE_SHORT))
                    //Level_Sell = SERVER_SYMBOL_ASK;
                // if(spd > SELECTED_EN_DISTANCE_SHORT)
                // {
                // }                
                //BottomChange += 200;
            }

        // }
        // else if(temp_vol > 2 && temp_vol < 4)
        // {
        //     if(pos_status == 0) // comprado
        //     {

        //     }
        //     else // vendido
        //     {
        //     }

        // }
        if(temp_vol > 3)
        {
           if(pos_status == 0) // comprado
            {
                Sell_Vol = SELECTED_VOLUME_SHORT * 2;
            }
            else // vendido
            {
                
                Buy_Vol = SELECTED_VOLUME_LONG * 2;
            }
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 2 // contra a tendência
        ) 
    {
        if(pos_status == 0) // comprado
        {
            if(sequenciaDeEntradaNivelInferior > 1)
                Sell_Vol = SELECTED_VOLUME_SHORT * 2;
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            
            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_ASK <  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG))
            //     {
            //         //Level_Sell = Freeze_Central_Bottom; 
                    
            //         Level_Sell = SERVER_SYMBOL_ASK; 
            //         Sell_Vol = SELECTED_VOLUME_SHORT ;
            //     }
            // }

        }
        else
        {
            distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        }

        if(pos_status == 1) // vendido
        {
            //Level_Buy = (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            if(sequenciaDeEntradaNivelSuperior > 1)
            Buy_Vol = SELECTED_VOLUME_LONG * 2;

            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_BID >  (Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT))
            //     {
                    
            //         //Level_Buy = Freeze_Central_Top;  
                    
            //         Level_Buy = SERVER_SYMBOL_BID; 
            //         Buy_Vol = SELECTED_VOLUME_LONG ;
            //     }
            // }

            //BuyVolChange  += SELECTED_VOLUME_LONG;
            //Buy_Vol  = temp_vol; // exemplo de possibilidade
            //Buy_Vol  = temp_vol/2; // exemplo de possibilidade
        }
        else
        {
            distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 3 // contra a tendência na zona de transição
        ) 
    {
        if(pos_status == 0) // comprado
        {
            if(sequenciaDeEntradaNivelInferior > 0)
                Sell_Vol = SELECTED_VOLUME_SHORT * 2;
            //Level_Sell = (Freeze_Central_Top - SELECTED_EN_DISTANCE_SHORT);
            
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            //BottomChange = 0;

        }
        else // vendido
        {
            distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        }
        if(pos_status == 1) // vendido
        {
            if(sequenciaDeEntradaNivelSuperior > 0)
                Buy_Vol = SELECTED_VOLUME_LONG * 2;
            
            //Level_Buy =  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            //BuyVolChange  += SELECTED_VOLUME_LONG;
           // TopChange += 50;
        }
        else
        {
            distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 4 // não posicionado na zona de transição
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    else // não posicionado e sem tendência
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    return 1;
}
int ORD_Strategy_026()
{
    double temp_vol;
    definirVolumeAtualEmLoteOuUnidade(temp_vol);
    distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);

    if(
        atualEstadoSinteticoDoTrade == 1 // a favor da tendência
        )
    {        
       // elaborar uma estratégia de diatância que altera a distancia de acordo com o atualEstadoSinteticoDoTrade
       // elaborar uma estratégia de volume que altera a distancia de acordo com o atualEstadoSinteticoDoTrade
       
        //min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
       // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
       // if(temp_vol == 1)
        // {
        //         // em uma estratégia que visa a tendência, o ideal é increementar a distância para o lado oposto da posição quando o volume for 1

            if(pos_status == 0) // comprado
            {
                //TopChange += 200;
                //if(SERVER_SYMBOL_BID > (Freeze_Central_Top + SELECTED_EN_DISTANCE_LONG))
                // if(spd > SELECTED_EN_DISTANCE_LONG)
                // {
                //     Level_Buy = SERVER_SYMBOL_BID;
                // }
                //Buy_Vol = SELECTED_VOLUME_LONG * 2;
                BuyVolChange += SELECTED_VOLUME_LONG ;
             

            }
            else // vendido
            {

                //Sell_Vol = SELECTED_VOLUME_SHORT * 2;
                SellVolChange += SELECTED_VOLUME_SHORT ;
                //if(SERVER_SYMBOL_ASK < ( Freeze_Central_Bottom- SELECTED_EN_DISTANCE_SHORT))
                    //Level_Sell = SERVER_SYMBOL_ASK;
                // if(spd > SELECTED_EN_DISTANCE_SHORT)
                // {
                // }                
                //BottomChange += 200;
            }

        // }
        // else if(temp_vol > 2 && temp_vol < 4)
        // {
        //     if(pos_status == 0) // comprado
        //     {

        //     }
        //     else // vendido
        //     {
        //     }

        // }
        if(temp_vol > 3)
        {
           if(pos_status == 0) // comprado
            {
                Sell_Vol = SELECTED_VOLUME_SHORT * 2;
            }
            else // vendido
            {
                
                Buy_Vol = SELECTED_VOLUME_LONG * 2;
            }
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 2 // contra a tendência
        ) 
    {
        if(pos_status == 0) // comprado
        {
            SetTopMagneticMovie(); // (est 2x)
            if(sequenciaDeEntradaNivelInferior > 1)
                Sell_Vol = SELECTED_VOLUME_SHORT * 2;
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            
            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_ASK <  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG))
            //     {
            //         //Level_Sell = Freeze_Central_Bottom; 
                    
            //         Level_Sell = SERVER_SYMBOL_ASK; 
            //         Sell_Vol = SELECTED_VOLUME_SHORT ;
            //     }
            // }

        }
        else
        {
            distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        }

        if(pos_status == 1) // vendido
        {
            SetBottomMagneticMovie(); // (est 2x)
            //Level_Buy = (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            if(sequenciaDeEntradaNivelSuperior > 1)
            Buy_Vol = SELECTED_VOLUME_LONG * 2;

            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_BID >  (Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT))
            //     {
                    
            //         //Level_Buy = Freeze_Central_Top;  
                    
            //         Level_Buy = SERVER_SYMBOL_BID; 
            //         Buy_Vol = SELECTED_VOLUME_LONG ;
            //     }
            // }

            //BuyVolChange  += SELECTED_VOLUME_LONG;
            //Buy_Vol  = temp_vol; // exemplo de possibilidade
            //Buy_Vol  = temp_vol/2; // exemplo de possibilidade
        }
        else
        {
            distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 3 // contra a tendência na zona de transição
        ) 
    {
        if(pos_status == 0) // comprado
        {
            if(sequenciaDeEntradaNivelInferior > 0)
                Sell_Vol = SELECTED_VOLUME_SHORT * 2;
            //Level_Sell = (Freeze_Central_Top - SELECTED_EN_DISTANCE_SHORT);
            
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            //BottomChange = 0;

        }
        else // vendido
        {
            distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        }
        if(pos_status == 1) // vendido
        {
            if(sequenciaDeEntradaNivelSuperior > 0)
                Buy_Vol = SELECTED_VOLUME_LONG * 2;
            
            //Level_Buy =  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            //BuyVolChange  += SELECTED_VOLUME_LONG;
           // TopChange += 50;
        }
        else
        {
            distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 4 // não posicionado na zona de transição
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    else // não posicionado e sem tendência
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    return 1;
}
int ORD_Strategy_017()
{
    double temp_vol;
    definirVolumeAtualEmLoteOuUnidade(temp_vol);
    distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);

    if(
        atualEstadoSinteticoDoTrade == 1 // a favor da tendência
        )
    {        
       // elaborar uma estratégia de diatância que altera a distancia de acordo com o atualEstadoSinteticoDoTrade
       // elaborar uma estratégia de volume que altera a distancia de acordo com o atualEstadoSinteticoDoTrade
       
        //min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
       // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
       // if(temp_vol == 1)
        // {
        //         // em uma estratégia que visa a tendência, o ideal é increementar a distância para o lado oposto da posição quando o volume for 1

            if(pos_status == 0) // comprado
            {
                //TopChange += 200;
                //if(SERVER_SYMBOL_BID > (Freeze_Central_Top + SELECTED_EN_DISTANCE_LONG))
                // if(spd > SELECTED_EN_DISTANCE_LONG)
                // {
                //     Level_Buy = SERVER_SYMBOL_BID;
                // }
                //Buy_Vol = SELECTED_VOLUME_LONG * 2;
                BuyVolChange += SELECTED_VOLUME_LONG ;
             

            }
            else // vendido
            {

                //Sell_Vol = SELECTED_VOLUME_SHORT * 2;
                SellVolChange += SELECTED_VOLUME_SHORT ;
                //if(SERVER_SYMBOL_ASK < ( Freeze_Central_Bottom- SELECTED_EN_DISTANCE_SHORT))
                    //Level_Sell = SERVER_SYMBOL_ASK;
                // if(spd > SELECTED_EN_DISTANCE_SHORT)
                // {
                // }                
                //BottomChange += 200;
            }

        // }
        // else if(temp_vol > 2 && temp_vol < 4)
        // {
        //     if(pos_status == 0) // comprado
        //     {

        //     }
        //     else // vendido
        //     {
        //     }

        // }
        if(temp_vol > 3)
        {
           if(pos_status == 0) // comprado
            {
                Sell_Vol = SELECTED_VOLUME_SHORT * 2;
            }
            else // vendido
            {
                
                Buy_Vol = SELECTED_VOLUME_LONG * 2;
            }
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 2 // contra a tendência
        ) 
    {
        if(pos_status == 0) // comprado
        {
            //if(sequenciaDeEntradaNivelInferior > 1)
                Sell_Vol = SELECTED_VOLUME_SHORT * 3;
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            
            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_ASK <  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG))
            //     {
            //         //Level_Sell = Freeze_Central_Bottom; 
                    
            //         Level_Sell = SERVER_SYMBOL_ASK; 
            //         Sell_Vol = SELECTED_VOLUME_SHORT ;
            //     }
            // }

        }
        else
        {
            distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        }

        if(pos_status == 1) // vendido
        {
            //Level_Buy = (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
          //  if(sequenciaDeEntradaNivelSuperior > 1)
            Buy_Vol = SELECTED_VOLUME_LONG * 3;

            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_BID >  (Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT))
            //     {
                    
            //         //Level_Buy = Freeze_Central_Top;  
                    
            //         Level_Buy = SERVER_SYMBOL_BID; 
            //         Buy_Vol = SELECTED_VOLUME_LONG ;
            //     }
            // }

            //BuyVolChange  += SELECTED_VOLUME_LONG;
            //Buy_Vol  = temp_vol; // exemplo de possibilidade
            //Buy_Vol  = temp_vol/2; // exemplo de possibilidade
        }
        else
        {
            distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 3 // contra a tendência na zona de transição
        ) 
    {
        if(pos_status == 0) // comprado
        {
           // if(sequenciaDeEntradaNivelInferior > 0)
                Sell_Vol = SELECTED_VOLUME_SHORT * 2;
            //Level_Sell = (Freeze_Central_Top - SELECTED_EN_DISTANCE_SHORT);
            
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            //BottomChange = 0;

        }
        else // vendido
        {
            distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        }
        if(pos_status == 1) // vendido
        {
          //  if(sequenciaDeEntradaNivelSuperior > 0)
                Buy_Vol = SELECTED_VOLUME_LONG * 2;
            
            //Level_Buy =  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            //BuyVolChange  += SELECTED_VOLUME_LONG;
           // TopChange += 50;
        }
        else
        {
            distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 4 // não posicionado na zona de transição
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    else // não posicionado e sem tendência
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    return 1;
}
int ORD_Strategy_027()
{
    double temp_vol;
    definirVolumeAtualEmLoteOuUnidade(temp_vol);
    distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);

    if(
        atualEstadoSinteticoDoTrade == 1 // a favor da tendência
        )
    {        
       // elaborar uma estratégia de diatância que altera a distancia de acordo com o atualEstadoSinteticoDoTrade
       // elaborar uma estratégia de volume que altera a distancia de acordo com o atualEstadoSinteticoDoTrade
       
        //min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
       // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
       // if(temp_vol == 1)
        // {
        //         // em uma estratégia que visa a tendência, o ideal é increementar a distância para o lado oposto da posição quando o volume for 1

            if(pos_status == 0) // comprado
            {
                //TopChange += 200;
                //if(SERVER_SYMBOL_BID > (Freeze_Central_Top + SELECTED_EN_DISTANCE_LONG))
                // if(spd > SELECTED_EN_DISTANCE_LONG)
                // {
                //     Level_Buy = SERVER_SYMBOL_BID;
                // }
                //Buy_Vol = SELECTED_VOLUME_LONG * 2;
                BuyVolChange += SELECTED_VOLUME_LONG ;
             

            }
            else // vendido
            {

                //Sell_Vol = SELECTED_VOLUME_SHORT * 2;
                SellVolChange += SELECTED_VOLUME_SHORT ;
                //if(SERVER_SYMBOL_ASK < ( Freeze_Central_Bottom- SELECTED_EN_DISTANCE_SHORT))
                    //Level_Sell = SERVER_SYMBOL_ASK;
                // if(spd > SELECTED_EN_DISTANCE_SHORT)
                // {
                // }                
                //BottomChange += 200;
            }

        // }
        // else if(temp_vol > 2 && temp_vol < 4)
        // {
        //     if(pos_status == 0) // comprado
        //     {

        //     }
        //     else // vendido
        //     {
        //     }

        // }
        if(temp_vol > 3)
        {
           if(pos_status == 0) // comprado
            {
                Sell_Vol = SELECTED_VOLUME_SHORT * 2;
            }
            else // vendido
            {
                
                Buy_Vol = SELECTED_VOLUME_LONG * 2;
            }
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 2 // contra a tendência
        ) 
    {
        if(pos_status == 0) // comprado
        {
            SetTopMagneticMovie(); // (est 2x)
            //if(sequenciaDeEntradaNivelInferior > 1)
                Sell_Vol = SELECTED_VOLUME_SHORT * 3;
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            
            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_ASK <  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG))
            //     {
            //         //Level_Sell = Freeze_Central_Bottom; 
                    
            //         Level_Sell = SERVER_SYMBOL_ASK; 
            //         Sell_Vol = SELECTED_VOLUME_SHORT ;
            //     }
            // }

        }
        else
        {
            distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        }

        if(pos_status == 1) // vendido
        {
            //Level_Buy = (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
          //  if(sequenciaDeEntradaNivelSuperior > 1)
            SetBottomMagneticMovie(); // (est 2x)
            Buy_Vol = SELECTED_VOLUME_LONG * 3;

            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_BID >  (Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT))
            //     {
                    
            //         //Level_Buy = Freeze_Central_Top;  
                    
            //         Level_Buy = SERVER_SYMBOL_BID; 
            //         Buy_Vol = SELECTED_VOLUME_LONG ;
            //     }
            // }

            //BuyVolChange  += SELECTED_VOLUME_LONG;
            //Buy_Vol  = temp_vol; // exemplo de possibilidade
            //Buy_Vol  = temp_vol/2; // exemplo de possibilidade
        }
        else
        {
            distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 3 // contra a tendência na zona de transição
        ) 
    {
        if(pos_status == 0) // comprado
        {
           // if(sequenciaDeEntradaNivelInferior > 0)
                Sell_Vol = SELECTED_VOLUME_SHORT * 2;
            //Level_Sell = (Freeze_Central_Top - SELECTED_EN_DISTANCE_SHORT);
            
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            //BottomChange = 0;

        }
        else // vendido
        {
            distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        }
        if(pos_status == 1) // vendido
        {
          //  if(sequenciaDeEntradaNivelSuperior > 0)
                Buy_Vol = SELECTED_VOLUME_LONG * 2;
            
            //Level_Buy =  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            //BuyVolChange  += SELECTED_VOLUME_LONG;
           // TopChange += 50;
        }
        else
        {
            distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        }
    }
    else if(
            atualEstadoSinteticoDoTrade == 4 // não posicionado na zona de transição
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    else // não posicionado e sem tendência
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    return 1;
}
int ORD_Strategy_018()
{
    distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
    if(atualEstadoSinteticoDoTrade == 1) // a favor da tendência
    {        
        SetSisSettings_01();
    }
    else if(atualEstadoSinteticoDoTrade == 2) // contra a tendência
    {
        SetSisSettings_02();
    }
    
    else if(atualEstadoSinteticoDoTrade == 3) // contra a tendência na zona de transição
    {
        SetSisSettings_03();
    }
    else if(atualEstadoSinteticoDoTrade == 4) // não posicionado na zona de transição 
    {
        SetSisSettings_04();
    }
    else if(atualEstadoSinteticoDoTrade == 5) // não posicionado e sem tendência
    {
        SetSisSettings_05();
    }
    return 1;
}
int ORD_Strategy_019()
{
    
    if(atualEstadoSinteticoDoTrade == 1) // a favor da tendência
    {
        //exemplo        
        //distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        SetSisSettings_01();
    }
    else if(atualEstadoSinteticoDoTrade == 2) // contra a tendência
    {
        SetSisSettings_02();
    }
    else if(atualEstadoSinteticoDoTrade == 3) // contra a tendência na zona de transição
    {
        SetSisSettings_03();
    }
    else if(atualEstadoSinteticoDoTrade == 4) // não posicionado na zona de transição 
    {
        SetSisSettings_04();
    }
    else if(atualEstadoSinteticoDoTrade == 5) // não posicionado e sem tendência
    {
        SetSisSettings_05();
    }
    return 1;
}

int ORD_Strategy_012_old()
{
    double temp_vol;
    definirVolumeAtualEmLoteOuUnidade(temp_vol);

    if(
        atualEstadoDoTrade == 1 // subindo e comprado
        )
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        //min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
       // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
        if(temp_vol > 2 && temp_vol < 4)
        {
            //Buy_Vol  = SELECTED_VOLUME_LONG * 2; // é mais agressivo para tendência
            Buy_Vol  = SELECTED_VOLUME_LONG;
        }
        else 
        {
            Buy_Vol  = SELECTED_VOLUME_LONG;
        }
        if(temp_vol > 4)
        {
            Sell_Vol  = SELECTED_VOLUME_SHORT * 2;
        }
        else
        {
            Sell_Vol  = SELECTED_VOLUME_SHORT ;
        }

    }
    else if(
            atualEstadoDoTrade == 2 // subindo e vendido
        ) 
    {
        Level_Buy = SERVER_SYMBOL_BID;
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        //BottomChange = 0;
        
        Buy_Vol  = SELECTED_VOLUME_LONG * 2;
        Sell_Vol  = SELECTED_VOLUME_SHORT ;
    }
    else if(
            atualEstadoDoTrade == 3 // caindo e comprado
        ) 
    {
        Level_Sell = SERVER_SYMBOL_ASK;
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        //TopChange = 0;
        Buy_Vol  = SELECTED_VOLUME_LONG ;
        Sell_Vol  = SELECTED_VOLUME_SHORT * 2;
    }
    else if(
            atualEstadoDoTrade == 4 // caindo e vendido
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        //min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
       // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;

        if(temp_vol > 2 && temp_vol < 4)
        {
            Sell_Vol  = SELECTED_VOLUME_SHORT ;
            //Sell_Vol  = SELECTED_VOLUME_SHORT ; //mais agressivo para tendência
        }
        else 
        {
            Sell_Vol  = SELECTED_VOLUME_SHORT ;
        }
        if(temp_vol > 4)
        {
            Buy_Vol  = SELECTED_VOLUME_LONG * 2;
        }
        else
        {
            Buy_Vol  = SELECTED_VOLUME_LONG;
        }
    }
    else if(
            atualEstadoDoTrade == 5 // zerado e subindo
        ) 
    {
        Buy_Vol  = SELECTED_VOLUME_LONG ;
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    else if(
            atualEstadoDoTrade == 6 // zerado e caindo
        ) 
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        Sell_Vol  = SELECTED_VOLUME_SHORT;
    }
    else
    {
        distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
        Buy_Vol  = SELECTED_VOLUME_LONG;
        Sell_Vol  = SELECTED_VOLUME_SHORT;
    }
    return 1;
}
int ORD_Strategy_001_backuop()
{
    // da pra mexer no min add e real pela estratégia quando for contra por exemplo
    // trabalhar o afastamento da média como parâmetro de entrada e saída de trade
    // so vender acima do PM (Ações)
    Print("ORD_Strategy_001");
    if(
        atualEstadoDoTrade == 1
        )
    {
        min_add_buy_modify = EN_Distance_Long;
        min_reduce_sell_modify = EN_Distance_Short;
        Buy_Vol  = SELECTED_VOLUME_LONG * 2;
        Sell_Vol  = SELECTED_VOLUME_SHORT * 1;
    }
    else if(
            atualEstadoDoTrade == 2
        ) 
    {
        min_add_sell_modify = EN_Distance_Short; // add não variável
        Buy_Vol  = SELECTED_VOLUME_LONG * 3;
        Sell_Vol  = SELECTED_VOLUME_SHORT * 1;
    }
    else if(
            atualEstadoDoTrade == 3
        ) 
    {
        min_add_buy_modify = EN_Distance_Long; // add não variável 
        Buy_Vol  = SELECTED_VOLUME_LONG * 1;
        Sell_Vol  = SELECTED_VOLUME_SHORT * 3;
    }
    else if(
            atualEstadoDoTrade == 4
        ) 
    {
        min_add_sell_modify = EN_Distance_Short; 
        min_reduce_buy_modify = EN_Distance_Long;
        Buy_Vol  = SELECTED_VOLUME_LONG * 1;
        Sell_Vol  = SELECTED_VOLUME_SHORT * 2;
    }


    //definirDistanciaDoLevel_cfg_10();

    FINAL_LONG_VOLUME  = Buy_Vol;
    FINAL_SHORT_VOLUME  = Sell_Vol;    

    return 1;

}
int ORD_Strategy_002_old()
{
    
    
    if(
        atualEstadoDoTrade == 1
        )
    {
        min_add_buy_modify = EN_Distance_Long;
       // min_reduce_sell_modify = EN_Distance_Short;
        Buy_Vol  = SELECTED_VOLUME_LONG * 2;
        Sell_Vol  = SELECTED_VOLUME_SHORT * 1;
    }
    else if(
            atualEstadoDoTrade == 2
        ) 
    {
        min_add_sell_modify = EN_Distance_Short; // add não variável
        Buy_Vol  = SELECTED_VOLUME_LONG * 3;
        Sell_Vol  = SELECTED_VOLUME_SHORT * 1;
    }
    else if(
            atualEstadoDoTrade == 3
        ) 
    {
        min_add_buy_modify = EN_Distance_Long; // add não variável 
        Buy_Vol  = SELECTED_VOLUME_LONG * 1;
        Sell_Vol  = SELECTED_VOLUME_SHORT * 3;
    }
    else if(
            atualEstadoDoTrade == 4
        ) 
    {
        min_add_sell_modify = EN_Distance_Short; 
       // min_reduce_buy_modify = EN_Distance_Long;
        Buy_Vol  = SELECTED_VOLUME_LONG * 1;
        Sell_Vol  = SELECTED_VOLUME_SHORT * 2;
    }


    //definirDistanciaDoLevel_cfg_10();

    FINAL_LONG_VOLUME  = Buy_Vol;
    FINAL_SHORT_VOLUME  = Sell_Vol;    

    return 1;
}
int ORD_Strategy_003_OLD()
{
    Print("ORD_Strategy_003");
    
    if(
        atualEstadoDoTrade == 1
        )
    {
        min_add_buy_modify = EN_Distance_Long;
        min_reduce_sell_modify = EN_Distance_Short;
        if(pos_volume < MdlTrend_Gravit_Vol)
        {
            Buy_Vol  = SELECTED_VOLUME_LONG * 2;
            Sell_Vol  = SELECTED_VOLUME_SHORT * 1;
        }
        else
        {
            Buy_Vol  = SELECTED_VOLUME_LONG * 1;
            Sell_Vol  = SELECTED_VOLUME_SHORT * 2;
        }

    }
    else if(
            atualEstadoDoTrade == 2
        ) 
    {
        min_add_sell_modify = EN_Distance_Short; // add não variável
        Buy_Vol  = SELECTED_VOLUME_LONG * 3;
        Sell_Vol  = SELECTED_VOLUME_SHORT * 1;
    }
    else if(
            atualEstadoDoTrade == 3
        ) 
    {
        min_add_buy_modify = EN_Distance_Long; // add não variável 
        Buy_Vol  = SELECTED_VOLUME_LONG * 1;
        Sell_Vol  = SELECTED_VOLUME_SHORT * 3;
    }
    else if(
            atualEstadoDoTrade == 4
        ) 
    {
        min_add_sell_modify = EN_Distance_Short; 
        min_reduce_buy_modify = EN_Distance_Long;
       
        if(pos_volume < MdlTrend_Gravit_Vol)
        {
            Buy_Vol  = SELECTED_VOLUME_LONG * 1;
            Sell_Vol  = SELECTED_VOLUME_SHORT * 2;
        }
        else
        {
            Buy_Vol  = SELECTED_VOLUME_LONG * 2;
            Sell_Vol  = SELECTED_VOLUME_SHORT * 1;
        }
       
       
    }


    //definirDistanciaDoLevel_cfg_10();

    FINAL_LONG_VOLUME  = Buy_Vol;
    FINAL_SHORT_VOLUME  = Sell_Vol;    

    return 1;
}
int ORD_Strategy_004_old()
{
    Print("ORD_Strategy_004");
    
    if(
        atualEstadoDoTrade == 1
        )
    {
        min_add_buy_modify = EN_Distance_Long;
        min_reduce_sell_modify = EN_Distance_Short;
        if(pos_volume < MdlTrend_Gravit_Vol)
        {
            
            if(madst > MaSpreadActivator ) // uso do distanciamento da média de ref.
            {
                Buy_Vol  = SELECTED_VOLUME_LONG * 1;
            }
            else
            {
                Buy_Vol  = SELECTED_VOLUME_LONG * 2;
            }
            
            
            Sell_Vol  = SELECTED_VOLUME_SHORT * 1;
        }
        else
        {
            Buy_Vol  = SELECTED_VOLUME_LONG * 1;
            Sell_Vol  = SELECTED_VOLUME_SHORT * 2;
        }

    }
    else if(
            atualEstadoDoTrade == 2
        ) 
    {
        min_add_sell_modify = EN_Distance_Short; // add não variável
        Buy_Vol  = SELECTED_VOLUME_LONG * 3;
        Sell_Vol  = SELECTED_VOLUME_SHORT * 1;
    }
    else if(
            atualEstadoDoTrade == 3
        ) 
    {
        min_add_buy_modify = EN_Distance_Long; // add não variável 
        Buy_Vol  = SELECTED_VOLUME_LONG * 1;
        Sell_Vol  = SELECTED_VOLUME_SHORT * 3;
    }
    else if(
            atualEstadoDoTrade == 4
        ) 
    {
        min_add_sell_modify = EN_Distance_Short; 
        min_reduce_buy_modify = EN_Distance_Long;
       
        if(pos_volume < MdlTrend_Gravit_Vol)
        {


            Buy_Vol  = SELECTED_VOLUME_LONG * 1;
            
            if(madst > MaSpreadActivator ) // uso do distanciamento da média de ref.
            {
                Sell_Vol  = SELECTED_VOLUME_SHORT * 1;
            }
            else
            {
                Sell_Vol  = SELECTED_VOLUME_SHORT * 2;
            }
        }
        else
        {
            Buy_Vol  = SELECTED_VOLUME_LONG * 2;
            Sell_Vol  = SELECTED_VOLUME_SHORT * 1;
        }
       
       
    }

    distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);

    //definirDistanciaDoLevel_cfg_10();

    FINAL_LONG_VOLUME  = Buy_Vol;
    FINAL_SHORT_VOLUME  = Sell_Vol;    

    return 1;
}
int ORD_Strategy_005_old()
{
    Print("ORD_Strategy_005");
    
   SELECTED_BUY_FIRST = true;

    Buy_Vol  = SELECTED_VOLUME_LONG * 2;
    Sell_Vol  = SELECTED_VOLUME_SHORT * 1;
    distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
    return 1;
}
int ORD_Strategy_007_old()
{

    

    if(
        atualEstadoDoTrade == 1
        )
    {

        SELECTED_BUY_FIRST = true;
    }
    else if(
            atualEstadoDoTrade == 2
        ) 
    {
        SELECTED_BUY_FIRST = true;
       // Buy_Vol  = SELECTED_VOLUME_LONG * 3;
       // Sell_Vol  = SELECTED_VOLUME_SHORT * 1;
    }
    else if(
            atualEstadoDoTrade == 3
        ) 
    {
        SELECTED_SELL_FIRST = true;
       // min_add_buy_modify = EN_Distance_Long; // add não variável 
      //  Buy_Vol  = SELECTED_VOLUME_LONG * 1;
       // Sell_Vol  = SELECTED_VOLUME_SHORT * 3;
    }
    else if(
            atualEstadoDoTrade == 4
        ) 
    {
        SELECTED_SELL_FIRST = true;
      //  min_add_sell_modify = EN_Distance_Short; 
     //   min_reduce_buy_modify = EN_Distance_Long;
    //    Buy_Vol  = SELECTED_VOLUME_LONG * 1;
     //   Sell_Vol  = SELECTED_VOLUME_SHORT * 2;
    }


    return 0;
}
