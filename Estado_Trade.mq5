//+------------------------------------------------------------------+
//|                                                        Trend.mq5 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                                 https://mql5.com |
//+------------------------------------------------------------------+


#include "Tech_Trading_Status_01.mq5"
#include "Tech_Trading_Status_02.mq5"
#include "Tech_Trading_Status_03.mq5"
#include "Tech_Trading_Status_04.mq5"
#include "Tech_Trading_Status_05.mq5"



int ultimoEstadoDoTrade = 0;
int ultimoEstadoSinteticoDoTrade = 0;
int atualEstadoSinteticoDoTrade = 0;


bool STATUS_SYSTEM_CHANGED = false;
bool TRADING_STATUS_CHANGED = false;

//int Basic_Trend_System() // criar lá no trend



int estadoDoTrade(int config)
{
    switch(config)
    {
        case 1:
            return definirEstadoDoTrade_cfg_1();
            break;            
    }
    return 0;    
}




int definirEstadoDoTrade_cfg_1()
{
    int estadoDoTrade = 0;

    if(pos_volume > 0)
    {
        if(// subindo e comprado
            CurrentTrend == 1
            && pos_status == 0 
            )
        {
            estadoDoTrade = 1;// atualEstadoDoTrade = 1;
        }
        else if(// subindo e vendido
            CurrentTrend ==  1
            && pos_status == 1 
            )
        {
            estadoDoTrade = 2; //atualEstadoDoTrade = 2;
        }
        else if(// caindo e comprado
            CurrentTrend == -1 
            && pos_status == 0
            )
        {
            estadoDoTrade = 3; //atualEstadoDoTrade = 3;

        }
        else if(// caindo e vendido
            CurrentTrend == -1 
            && pos_status == 1
            ) 
        {
            estadoDoTrade = 4; //atualEstadoDoTrade = 4;
        }
        else if(// neutro e comprado
            CurrentTrend == 0 
            && pos_status == 0
            ) 
        {
            estadoDoTrade = 7; //atualEstadoDoTrade = 7;
        }
        else if(// neutro e vendido
            CurrentTrend == 0 
            && pos_status == 1
            ) 
        {
            estadoDoTrade = 8; //atualEstadoDoTrade = 8;
        }
    }
    else if(CurrentTrend == 1) // zerado e subindo
    {
        estadoDoTrade = 5; //return 5;
    }
    else if(CurrentTrend == -1) // zerado e caindo
    {
        estadoDoTrade = 6;//return 6;
    }
    else // zerado e neutro
    {
        estadoDoTrade = 9;// 
    }
    
    return estadoDoTrade;
}


int estadoSinteticoDoTrade(int estadoDoTrade)
{
    int estadoSinteticoDoTrade = 0;
    
    switch(estadoDoTrade)
    {
        case 1:
            estadoSinteticoDoTrade = 1; // a favor da tendência
            break;
        case 4:
            estadoSinteticoDoTrade = 1;
            break;
        case 2:
            estadoSinteticoDoTrade = 2; // contra a tendência
            break;
        case 3:
            estadoSinteticoDoTrade = 2;
            break;
        case 7:
            estadoSinteticoDoTrade = 3; // contra a tendência na zona de transição
            break;
        case 8:
            estadoSinteticoDoTrade = 3;
            break;
        case 5:
            estadoSinteticoDoTrade = 4; // não posicionado e tendência
            break;
        case 6:
            estadoSinteticoDoTrade = 4;
            break;
        default:
            estadoSinteticoDoTrade = 5; // não posicionado e zona de transição
            break;
    }
    return estadoSinteticoDoTrade;
}


bool estadoDoTradeMudou(){

    ultimoEstadoDoTrade = atualEstadoDoTrade;
    atualEstadoDoTrade = estadoDoTrade(1);


    if(ultimoEstadoDoTrade != atualEstadoDoTrade)
    {
        TRADING_STATUS_CHANGED = true;
        return true;
    }
    else
    {
        TRADING_STATUS_CHANGED = false;
        return false;
    }

}

bool estadoSinteticoDoTradeMudou(){

    ultimoEstadoSinteticoDoTrade = atualEstadoSinteticoDoTrade;
    atualEstadoSinteticoDoTrade = estadoSinteticoDoTrade(estadoDoTrade(1));

    if(ultimoEstadoSinteticoDoTrade != atualEstadoSinteticoDoTrade)
    {
        STATUS_SYSTEM_CHANGED = true;
        return true;
    }
    else
    {
        STATUS_SYSTEM_CHANGED = false;
        return false;

    }

}