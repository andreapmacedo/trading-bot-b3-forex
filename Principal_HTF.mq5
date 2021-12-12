



double CurrentPositionVol;// = MyGetVolumePosition();
int CurrentPositionSide;// = MyGetPosition();
//int CurrentTrend = Trend_Settings(SELECTED_EST_TREND_CHOSEN);
int CurrentTrend;// = Trend_Settings(eTrend_001);

int atualEstadoDoTrade = 0;

double TopChange = 0;
double BottomChange = 0;

double BuyVolChange = 0;
double SellVolChange = 0;

bool BUY_TREND_OK = true;
bool SELL_TREND_OK = true;

bool TREND_MODE = false;


void Sys_Follow_8_Reset_Vars()
{
    min_add_buy_modify = 0;
    min_add_sell_modify = 0;
    min_reduce_buy_modify = 0;
    min_reduce_sell_modify = 0;



    BUY_TREND_OK = true;
    SELL_TREND_OK = true;


    BREAK_MODE = false;

    TopChange = 0;
    BottomChange = 0;
    BuyVolChange = 0;
    SellVolChange = 0;


    Level_Sell = SERVER_SYMBOL_ASK + SELECTED_EN_DISTANCE_SHORT;
    Level_Buy = SERVER_SYMBOL_BID - SELECTED_EN_DISTANCE_LONG;
    Buy_Vol  = SELECTED_VOLUME_LONG;
    Sell_Vol  = SELECTED_VOLUME_SHORT ;

    SELECTED_TP_ON = TP_ON;
    SELECTED_SL_ON = SL_ON;

}


double volumeAtualDaPosicao;

double volumeInferiorDaOrdem;
double volumeSuperiorDaOrdem;

double nivelInferiorDaOrdem ;
double nivelSuperiorDaOrdem;

double ajusteNivelInferiorDaOrdem = 0;
double ajusteNivelSuperiorDaOrdem = 0;

double ajusteVolumeInferiorDaOrdem = 0;
double ajusteVolumeSuperiorDaOrdem = 0;


int principalHTF(int callFrom)
{
    //+------------------------------------------------------------------+
	// Condições inicialmente refutadas para conclusão do cíclo principal
	//+------------------------------------------------------------------+	
    
    if(callFrom == 1)
    {
        return -1;        
    }    
	//+------------------------------------------------------------------+
	// Inicialização de variáveis 
	//+------------------------------------------------------------------+	
    Sys_Follow_8_Reset_Vars();
    CountAllOrdersForPairType();


    definirNivelInferiorDaOrdem(SERVER_SYMBOL_BID - SELECTED_EN_DISTANCE_LONG);
    definirNivelSuperiorDaOrdem(SERVER_SYMBOL_ASK + SELECTED_EN_DISTANCE_SHORT);
    definirVolumeInferiorDaOrdem(SELECTED_VOLUME_LONG);
    definirVolumeSuperiorDaOrdem(SELECTED_VOLUME_SHORT);
    

    definirAjusteNivelInferiorDaOrdem(0);
    definirAjusteNivelSuperiorDaOrdem(0);
    definirAjusteVolumeInferiorDaOrdem(0);
    definirAjusteVolumeSuperiorDaOrdem(0);
        if(Level_Sell != nivelSuperiorDaOrdem){
            Print("Inconsistência no level superior - inicio!");
            Print("Level_Sell -> ", Level_Sell);
            Print("nivelSuperiorDaOrdem -> ", nivelSuperiorDaOrdem);

        }

        if(Level_Buy != nivelInferiorDaOrdem){

            Print("Inconsistência no level inferior - inicio!");
            Print("Level_Buy -> ", Level_Buy);
            Print("nivelInferiorDaOrdem -> ", nivelInferiorDaOrdem);

        }      

    volumeAtualDaPosicao = caracterizarVolume(pos_volume);



    //definirVolumeAtualEmLoteOuUnidade(volumeAtualDaPosicao);




	//+------------------------------------------------------------------+
	// Verifica a mudança de estado do trade
	//+------------------------------------------------------------------+	

    if(estadoDoTradeMudou())
    {
        if(countListening == 1 || countListening == 4)
        {
            Print("estado do trade mudou - principalHTF");   
            SO_FOLLOW_LOCK = 0;
        }        
    }

    if(callFrom == 5)
    {
        SO_FOLLOW_LOCK = 0;
    }

    if(callFrom == 3)
    {
        ResetAxlesLevels();
        CountFreezeCentralLevel == 0;
        Print("call from 3");
        SO_FOLLOW_LOCK = 0;
    }
    else if(TotalSymbolOrderBuy == 0 && SELECTED_LONG_POSITION_ON && !SELECTED_SELL_FIRST && !DYT_SELL_FIRST)
    {
        //if(pos_volume >= SELECTED_LIMIT_POSITION_VOLUME)
        if(volumeAtualDaPosicao >= SELECTED_LIMIT_POSITION_VOLUME)
        {
            SO_FOLLOW_LOCK = 0;
                Print("call from 2 ENFORCE");
        }
        else if(countListening == 1)    
        {
            SO_FOLLOW_LOCK = 0;
            Print("call from 22 ENFORCE");
            ResetAxlesLevels();
            CountFreezeCentralLevel == 0;
        }
    }
    else if(TotalSymbolOrderSell == 0 && SELECTED_SHORT_POSITION_ON && !SELECTED_BUY_FIRST && !DYT_BUY_FIRST)
    {
        //if(pos_volume >= SELECTED_LIMIT_POSITION_VOLUME)
        if(volumeAtualDaPosicao >= SELECTED_LIMIT_POSITION_VOLUME)
        {
            SO_FOLLOW_LOCK = 0;
            Print("call from 4 ENFORCE");
        }
        else if(countListening == 1 )
        {
            SO_FOLLOW_LOCK = 0;
            Print("call from 44 ENFORCE");
            ResetAxlesLevels();
            CountFreezeCentralLevel == 0;
        }
    }

    //+------------------------------------------------------------------+
    // Ciclo principal da execução  
    //+------------------------------------------------------------------+	    

    if(SO_FOLLOW_LOCK == 0 || FOLLOW_MODE || estadoSinteticoDoTrade(estadoDoTrade(1)) == 2)
    {
        SO_FOLLOW_LOCK = 1;
        SetCentalAxles_evo(2);

        //+------------------------------------------------------------------+
        // Trata a condição de extrapolação do limite de volume estabelecido ou do sistema follow 
        //+------------------------------------------------------------------+	
        
        if(FOLLOW_MODE || volumeAtualDaPosicao >= SELECTED_LIMIT_POSITION_VOLUME)
        {
            SetAllFlows(); 
            Level_Sell = Lowest_Top;
            Level_Buy = Highest_Bottom;
            
            definirNivelSuperiorDaOrdem(Lowest_Top);
            definirNivelInferiorDaOrdem(Highest_Bottom);

        }
        else
        {
            Level_Sell = Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT;
            Level_Buy = Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG;      
            
            definirNivelSuperiorDaOrdem(Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT);
            definirNivelInferiorDaOrdem(Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);

        }

        Sell_Vol = SELECTED_VOLUME_SHORT;
        Buy_Vol = SELECTED_VOLUME_LONG;
        

        definirVolumeSuperiorDaOrdem(SELECTED_VOLUME_SHORT);
        definirVolumeInferiorDaOrdem(SELECTED_VOLUME_LONG);



        //if(pos_volume >= SELECTED_LIMIT_POSITION_VOLUME)
        if(volumeAtualDaPosicao >= SELECTED_LIMIT_POSITION_VOLUME)
        {
            if(pos_status == 0) // 0 = comprado
            {
                
                Level_Buy = Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG;
                definirNivelInferiorDaOrdem(Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);

                if(TotalSymbolOrderBuy == 0) // só chama o spd se não tiver mais ordem a ser exec. do lado que vai sofrer o stop
                {
                    SetSpdReverse3();
                }
            }
            else
            {
                Level_Sell = Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT;       
                definirNivelSuperiorDaOrdem(Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT);
                if(TotalSymbolOrderSell == 0)
                {
                    SetSpdReverse3();
                }

            }
        }   


        if(Level_Sell != nivelSuperiorDaOrdem){
            Print("Inconsistência no level superior - intermedium!");
            Print("Level_Sell -> ", Level_Sell);
            Print("nivelSuperiorDaOrdem -> ", nivelSuperiorDaOrdem);

        }

        if(Level_Buy != nivelInferiorDaOrdem){

            Print("Inconsistência no level inferior - intermedium!");
            Print("Level_Buy -> ", Level_Buy);
            Print("nivelInferiorDaOrdem -> ", nivelInferiorDaOrdem);

        }        
            

        //+------------------------------------------------------------------+
        // Definição de chamada para estratégias de dóminio ou de manipulação de atribulos 
        //+------------------------------------------------------------------+	

        int masterEstInterResponse = 0;
        if(SELECTED_TRADE_STRATEGY_CHOSEN > 0)
        {
            masterEstInterResponse = SetOrderStrategy(SELECTED_TRADE_STRATEGY_CHOSEN);
        }
        

        if(masterEstInterResponse == 0) // ou o master strategy está inoperante ou a estratégia não implicou a mudança de level ou volume
        {
            distanciaDoLevel(SELECTED_EST_EN_DISTANCE_CHOSEN);
            EN_OrderVolume_Settings(SELECTED_EST_VOLUME_CHOSEN);
            //Print("masterEstInterResponse == 0");
        }
        else if(masterEstInterResponse == 2)
        {
            return -1;
        }


        //+------------------------------------------------------------------+
        // Módulo de verificação de distância e volume máximo de adição estabelecidos 
        //+------------------------------------------------------------------+	
        
        if(TopChange > ajusteMaximoDeDistancia && ajusteMaximoDeDistancia > 0){
            TopChange = ajusteMaximoDeDistancia;
            definirAjusteNivelSuperiorDaOrdem(ajusteMaximoDeDistancia);
        }

        if(BottomChange > ajusteMaximoDeDistancia && ajusteMaximoDeDistancia > 0){
            BottomChange = ajusteMaximoDeDistancia;
            definirAjusteNivelInferiorDaOrdem(ajusteMaximoDeDistancia);
        }

        if(BuyVolChange > ajusteMaximoDeVolume && ajusteMaximoDeVolume > 0){
            BuyVolChange = ajusteMaximoDeVolume;
            definirAjusteVolumeInferiorDaOrdem(ajusteMaximoDeVolume);
        }

        if(SellVolChange > ajusteMaximoDeVolume && ajusteMaximoDeVolume > 0){
            SellVolChange = ajusteMaximoDeVolume;
            definirAjusteVolumeSuperiorDaOrdem(ajusteMaximoDeVolume);

        }
        
        //+------------------------------------------------------------------+
        // Atribuição final de níveis de volumes das ordens 
        //+------------------------------------------------------------------+	


        if(Level_Sell != nivelSuperiorDaOrdem){
            Print("Inconsistência no level superior - pré final HTF!");
            Print("Level_Sell -> ", Level_Sell);
            Print("nivelSuperiorDaOrdem -> ", nivelSuperiorDaOrdem);

        }

        if(Level_Buy != nivelInferiorDaOrdem){

            Print("Inconsistência no level inferior - pré final HTF!");
            Print("Level_Buy -> ", Level_Buy);
            Print("nivelInferiorDaOrdem -> ", nivelInferiorDaOrdem);

        }



        Level_Sell += TopChange;
        Level_Buy -= BottomChange;

        Buy_Vol += BuyVolChange;
        Sell_Vol += SellVolChange;


        definirNivelSuperiorDaOrdem(nivelSuperiorDaOrdem + ajusteNivelSuperiorDaOrdem);
        definirNivelInferiorDaOrdem(nivelInferiorDaOrdem  - ajusteNivelInferiorDaOrdem);
        
        definirVolumeInferiorDaOrdem(volumeInferiorDaOrdem + ajusteVolumeInferiorDaOrdem);
        definirVolumeSuperiorDaOrdem(volumeSuperiorDaOrdem + ajusteVolumeSuperiorDaOrdem);
        
        //+------------------------------------------------------------------+
        // Módulo de verificação de distâncias mínimas de ordens estabelecidas 
        //+------------------------------------------------------------------+	

        if(Level_Sell != nivelSuperiorDaOrdem){
            Print("Inconsistência no level superior - pré HTF!");
            Print("Level_Sell -> ", Level_Sell);
            Print("nivelSuperiorDaOrdem -> ", nivelSuperiorDaOrdem);

        }

        if(Level_Buy != nivelInferiorDaOrdem){

            Print("Inconsistência no level inferior - pré HTF!");
            Print("Level_Buy -> ", Level_Buy);
            Print("nivelInferiorDaOrdem -> ", nivelInferiorDaOrdem);

        }


        //if((pos_volume < SELECTED_LIMIT_POSITION_VOLUME))
        if((volumeAtualDaPosicao < SELECTED_LIMIT_POSITION_VOLUME))
        {    
            if(Freeze_Central_Top > 0 && Freeze_Central_Bottom > 0)
            {
                if(MIN_ADD_DISTANCE > 0)
                    SetAddChange_Evo();
                
                if(MIN_REDUCE_DISTANCE >0)
                    SetRdcChange_Evo();
                    
            }
        }  
        
        //+------------------------------------------------------------------+
        // Temporário
        //+------------------------------------------------------------------+	
        // Módulo temporário para comparação de variáveis de reetruturação do código

        if(Level_Sell != nivelSuperiorDaOrdem){
            Print("Inconsistência no level superior - HTF!");
            Print("Level_Sell -> ", Level_Sell);
            Print("nivelSuperiorDaOrdem -> ", nivelSuperiorDaOrdem);

        }

        if(Level_Buy != nivelInferiorDaOrdem){

            Print("Inconsistência no level inferior - HTF!");
            Print("Level_Buy -> ", Level_Buy);
            Print("nivelInferiorDaOrdem -> ", nivelInferiorDaOrdem);

        }

        

        //+------------------------------------------------------------------+
        // Verifica se as ordens estão dentro das faixas do Bid Ask
        //+------------------------------------------------------------------+	

        //if(pos_volume < SELECTED_LIMIT_POSITION_VOLUME)
        if(volumeAtualDaPosicao < SELECTED_LIMIT_POSITION_VOLUME)
        {
            //se não for modo break
            if(SERVER_SYMBOL_BID > Level_Sell)
            //if(SERVER_SYMBOL_BID > nivelSuperiorDaOrdem)
            {
                Print("call from 100 ENFORCE");
                ResetAxlesLevels();
                CountFreezeCentralLevel == 0;

                Print("Enforce Reset Level_Sell: ", Level_Sell);                
                return -1;
            }
            if(SERVER_SYMBOL_ASK < Level_Buy)
            //if(SERVER_SYMBOL_ASK < nivelInferiorDaOrdem )
            {
                Print("call from 100 ENFORCE");
                ResetAxlesLevels();
                CountFreezeCentralLevel == 0;
                Print("Enforce Reset Level_Buy: ", Level_Buy);       
                return -1;
            }
        }
        
        

        //+------------------------------------------------------------------+
        // Chamadas de execução de ordens
        //+------------------------------------------------------------------+	
        if(Level_Sell != nivelSuperiorDaOrdem){
            Print("Inconsistência no level superior - pre call!");
            Print("Level_Sell -> ", Level_Sell);
            Print("nivelSuperiorDaOrdem -> ", nivelSuperiorDaOrdem);

        }

        if(Level_Buy != nivelInferiorDaOrdem){

            Print("Inconsistência no level inferior - pre call!");
            Print("Level_Buy -> ", Level_Buy);
            Print("nivelInferiorDaOrdem -> ", nivelInferiorDaOrdem);

        }


    
        if(SELECTED_EN_MODE == 1)
        {
            int definirOrdens = definirOrdens();
    //        Set_Order_Limit(callFrom);
            return 2;
        }


        
    }
    return 0;

}



int definirNivelInferiorDaOrdem(double valor){

    nivelInferiorDaOrdem  = valor;
    return 0;
}
int definirNivelSuperiorDaOrdem(double valor){

    nivelSuperiorDaOrdem = valor;
    return 0;
}
int definirVolumeInferiorDaOrdem(double valor){

    volumeInferiorDaOrdem = valor;
    return 0;
}
int definirVolumeSuperiorDaOrdem(double valor){

    volumeSuperiorDaOrdem = valor;
    return 0;
}



void definirAjusteNivelSuperiorDaOrdem(double valor){
    ajusteNivelSuperiorDaOrdem = valor;
    
}

void aumentarNivelSuperiorDaOrdem(double valor){
    ajusteNivelSuperiorDaOrdem += valor;
    
}

void diminuirNivelSuperiorDaOrdem(double valor){
    ajusteNivelSuperiorDaOrdem -= valor;
    
}

void definirAjusteNivelInferiorDaOrdem (double valor){
    
    ajusteNivelInferiorDaOrdem = valor;
    
}

void aumentarNivelInferiorDaOrdem (double valor){
    
    ajusteNivelInferiorDaOrdem += valor;
    
}

void diminuirNivelInferiorDaOrdem (double valor){
    
    ajusteNivelInferiorDaOrdem -= valor;
    
}

void definirAjusteVolumeSuperiorDaOrdem (double valor){
    
    ajusteVolumeSuperiorDaOrdem = valor; 
}

void aumentarVolumeSuperiorDaOrdem(double valor){
    
    ajusteVolumeSuperiorDaOrdem += valor;
}

void diminuirtVolumeSuperiorDaOrdem(double valor){
    
    ajusteVolumeSuperiorDaOrdem -= valor;   
}



void definirAjusteVolumeInferiorDaOrdem (double valor){
// pode adicionar camada de proteção nesta área( verifica se ultrapassa o limite de volume)
    ajusteVolumeInferiorDaOrdem = valor; 
}

void aumentarVolumeInferiorDaOrdem(double valor){
    ajusteVolumeInferiorDaOrdem += valor;   
}

void diminuirVolumeInferiorDaOrdem(double valor){
    ajusteVolumeInferiorDaOrdem -= valor;   
}