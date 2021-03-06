//+------------------------------------------------------------------+
// Imports
//+------------------------------------------------------------------+
#include <Trade\Trade.mqh>
CTrade trade;


//+------------------------------------------------------------------+
// Global Vars
//+------------------------------------------------------------------+


int		 MagicNumber 	                     = 123456;
#define EXPERT_MAGIC 123456


int DEAL_ORDER_TYPE_TIME = 0;
int DEAL_ORDER_TYPE_FILLING = 0;


ENUM_ORDER_TYPE EN_ORDER_TYPE_LONG = ORDER_TYPE_BUY_LIMIT;
ENUM_ORDER_TYPE EN_ORDER_TYPE_SHORT = ORDER_TYPE_SELL_LIMIT;
//int var = ENUM_ORDER_TYPE(OrderGetInteger(ORDER_TYPE))


//https://www.mql5.com/pt/docs/constants/tradingconstants/enum_trade_request_actions#trade_action_deal
void definirOrdem(int orderType, double level, double sl, double tp, double vol) // USING
{

	countOrdersSend += 1;
	countOrdersDeals +=1;

	countDayOrdersSend += 1;
	countDayOrdersDeals += 1;



	MqlTradeRequest request={};
	MqlTradeResult  result={0};
	ZeroMemory(request);
	ZeroMemory(result);

	if(BREAK_MODE)
	{
		EN_ORDER_TYPE_LONG = ORDER_TYPE_BUY_STOP;
		EN_ORDER_TYPE_SHORT = ORDER_TYPE_SELL_STOP;		
	}

	//Print("level ", level);
	//Print("orderType ", orderType);
	//Print("orderType ", ENUM_ORDER_TYPE(OrderGetInteger(orderType)));


	//-- ordens a mercado
	if(orderType == ORDER_TYPE_SELL || orderType == ORDER_TYPE_BUY)
	{
		request.action   	= TRADE_ACTION_DEAL; 
		//request.price       = SymbolInfoDouble(Symbol(), SYMBOL_BID); // Pode ser criada uma condicional para o bid não executar com spread alto.
	//	request.price 		 = NormalizeDouble(level, _Digits); 
	}
	else//-- ordens de gatilho
	{
		request.action       = TRADE_ACTION_PENDING;
		request.price 		 = NormalizeDouble(level, _Digits); 

	}





    switch(DEAL_ORDER_TYPE_TIME)
    {
        case 0:
            request.type_filling = ORDER_FILLING_RETURN; 
            break;
        case 1:
			request.type_filling = ORDER_FILLING_FOK;
			break;
        case 2:
			request.type_filling = ORDER_FILLING_IOC;
			break;
        default:
            request.type_filling = ORDER_FILLING_RETURN; 
            break;
    }


	if(!DAY_TRADE_MODE && !TIME_FILTER)
	{
		//DEAL_ORDER_TYPE_FILLING == 1;
		request.type_time    = ORDER_TIME_GTC;//ORDER_TIME_GTC; //ORDER_TIME_DAY;
	}
	else
	{
		request.type_time    = ORDER_TIME_DAY;//ORDER_TIME_GTC; //ORDER_TIME_DAY; 

	}

    // switch(DEAL_ORDER_TYPE_FILLING)
    // {
    //     case 0:
    //         request.type_time    = ORDER_TIME_DAY;//ORDER_TIME_GTC; //ORDER_TIME_DAY; 
    //         break;
    //     case 1:
	// 		request.type_time    = ORDER_TIME_GTC;//ORDER_TIME_GTC; //ORDER_TIME_DAY;
	// 		break;
    //     default:
    //         request.type_time    = ORDER_TIME_DAY;//ORDER_TIME_GTC; //ORDER_TIME_DAY;
    //         break;
    // }
	
	
	/*
	if(DEAL_ORDER_TYPE_TIME == 1)
	{
		request.type_filling = ORDER_FILLING_FOK; //ORDER_FILLING_FOK; //ORDER_FILLING_FOK		
	}
	else if(DEAL_ORDER_TYPE_TIME == 2)
	{
		request.type_filling = ORDER_FILLING_IOC;
	}
	else
	{
		request.type_filling = ORDER_FILLING_RETURN; 
	}
	*/	
	/*
	if(DEAL_ORDER_TYPE_FILLING == 1)
	{
		request.type_time    = ORDER_TIME_GTC;//ORDER_TIME_GTC; //ORDER_TIME_DAY;
	}
	else
	{	
		request.type_time    = ORDER_TIME_DAY;//ORDER_TIME_GTC; //ORDER_TIME_DAY;
	}
	*/

	//request.type_filling = ORDER_FILLING_RETURN; 
	//request.type_time    = ORDER_TIME_DAY;//ORDER_TIME_GTC; //ORDER_TIME_DAY;
	request.magic        = EXPERT_MAGIC;                  // Nº mágico da ordem
	request.symbol       = _Symbol;                       // Simbolo do ativo
	request.volume       = vol;                           // Nº de Lotes
   
   
	// --- Preço de Stop Loss no caso de um movimento desfavorável de preço.	
	request.sl           = NormalizeDouble(sl, _Digits); 
	// --- Preço de Take Profit no caso de um movimento favorável de preço.
	request.tp           = NormalizeDouble(tp, _Digits);
	//-- O máximo desvio de preço, especificado em pontos
	request.deviation    = SELECTED_DEVIATION;                                       
	request.type         = orderType;                                       // Tipo da Ordem



	// https://www.mql5.com/pt/docs/constants/structures/mqltraderesult
	bool success=OrderSend(request,result);

	//--- se o resultado falha - tentar descobrir o porquê
	if(!success)
	{
			
      int answer=result.retcode;
      Print("TradeLog: Requisição de negociação falhou. Erro = ",GetLastError());
      switch(answer)
        {
         //--- nova cotação
         case 10004:
           {
            Print("TRADE_RETCODE_REQUOTE");
            Print("request.price = ",request.price,"   result.ask = ",
                  result.ask," result.bid = ",result.bid);
            break;
           }
         //--- ordem não é aceita pelo servidor
         case 10006:
           {
            Print("TRADE_RETCODE_REJECT");
            Print("request.price = ",request.price,"   result.ask = ",
                  result.ask," result.bid = ",result.bid);
            break;
           }
         //--- preço inválido
         case 10015:
           {
            Print("TRADE_RETCODE_INVALID_PRICE");
            Print("request.price = ",request.price,"   result.ask = ",
                  result.ask," result.bid = ",result.bid);
            break;
           }
         //--- SL e/ou TP inválidos
         case 10016:
           {
            Print("TRADE_RETCODE_INVALID_STOPS");
            Print("request.sl = ",request.sl," request.tp = ",request.tp);
            Print("result.ask = ",result.ask," result.bid = ",result.bid);
            break;
           }
         //--- volume inválido
         case 10014:
           {
            Print("TRADE_RETCODE_INVALID_VOLUME");
            Print("request.volume = ",request.volume,"   result.volume = ",
                  result.volume);
            break;
           }
         //--- sem dinheiro suficiente para uma operação de negociação
         case 10019:
           {
            Print("TRADE_RETCODE_NO_MONEY");
            Print("request.volume = ",request.volume,"   result.volume = ",
                  result.volume,"   result.comment = ",result.comment);
            break;
           }
         //--- alguma outra razão, saída com o código de resposta do servidor
         default:
           {
            Print("Outra resposta = ",answer);
           }
        }
		my_last_deal = my_current_deal;
		my_current_deal = level;



      //--- notifica sobre o resultado sem sucesso da solicitação de negociação retornando false
      //return(false);
    }
}

int Place_Order_Dev(int orderType, double level, double sl, double tp, double vol) // USING
{

	countOrdersSend += 1;
	countOrdersDeals +=1;

	countDayOrdersSend += 1;
	countDayOrdersDeals += 1;



	MqlTradeRequest request={};
	MqlTradeResult  result={0};
	ZeroMemory(request);
	ZeroMemory(result);


	//Print("level ", level);
	//Print("orderType ", orderType);
	//Print("orderType ", ENUM_ORDER_TYPE(OrderGetInteger(orderType)));

	// a Modal só aceita estes
	request.type_filling = ORDER_FILLING_RETURN;  
	request.type_time    = ORDER_TIME_DAY;

	//-- ordens a mercado
	if(orderType == ORDER_TYPE_SELL || orderType == ORDER_TYPE_BUY)
	{
		request.action   	= TRADE_ACTION_DEAL; 
		//request.price       = SymbolInfoDouble(Symbol(), SYMBOL_BID); // Pode ser criada uma condicional para o bid não executar com spread alto.
	//	request.price 		 = NormalizeDouble(level, _Digits); 
	
	}
	else//-- ordens de gatilho
	{
		request.action       = TRADE_ACTION_PENDING;
		if(level > 0)
		{
			request.price 		 = NormalizeDouble(level, _Digits);
		}
		else
		{
			Print("Erro preço = 0");
			return (-3); 
		}
	}
/*
    switch(DEAL_ORDER_TYPE_TIME)
    {
        case 0:
            request.type_filling = ORDER_FILLING_RETURN; 
            break;
        case 1:
			request.type_filling = ORDER_FILLING_FOK; //Esta política de preenchimento significa que uma ordem pode ser preenchida somente na quantidade especificada. Se a quantidade desejada do ativo não está disponível no mercado, a ordem não será executada. O volume requerido pode ser preenchido usando várias ofertas disponíveis no mercado no momento.
			break;
        case 2:
			request.type_filling = ORDER_FILLING_IOC; //Este modo significa que um negociador concorda em executar uma operação com o volume máximo disponível no mercado conforme indicado na ordem. No caso do volume integral de uma ordem não puder ser preenchido, o volume disponível dele será preenchido, e o volume restante será cancelado.
			break;
        default:
            request.type_filling = ORDER_FILLING_RETURN; // Apenas para ordem a mercado
            break;
    }
    switch(DEAL_ORDER_TYPE_FILLING)
    {
        case 0:
            request.type_time    = ORDER_TIME_DAY;//ORDER_TIME_GTC; //ORDER_TIME_DAY; 
            break;
        case 1:
			request.type_time    = ORDER_TIME_GTC;//ORDER_TIME_GTC; //ORDER_TIME_DAY;
			break;
        default:
            request.type_time    = ORDER_TIME_DAY;//ORDER_TIME_GTC; //ORDER_TIME_DAY;
            break;
    }
*/
	/*
	if(DEAL_ORDER_TYPE_TIME == 1)
	{
		request.type_filling = ORDER_FILLING_FOK; //ORDER_FILLING_FOK; //ORDER_FILLING_FOK		
	}
	else if(DEAL_ORDER_TYPE_TIME == 2)
	{
		request.type_filling = ORDER_FILLING_IOC;
	}
	else
	{
		request.type_filling = ORDER_FILLING_RETURN; 
	}
	*/	
	/*
	if(DEAL_ORDER_TYPE_FILLING == 1)
	{
		request.type_time    = ORDER_TIME_GTC;//ORDER_TIME_GTC; //ORDER_TIME_DAY;
	}
	else
	{	
		request.type_time    = ORDER_TIME_DAY;//ORDER_TIME_GTC; //ORDER_TIME_DAY;
	}
	*/

	//request.type_filling = ORDER_FILLING_RETURN; 
	//request.type_time    = ORDER_TIME_DAY;//ORDER_TIME_GTC; //ORDER_TIME_DAY;
	request.magic        = EXPERT_MAGIC;                  // Nº mágico da ordem
	request.symbol       = _Symbol;                       // Simbolo do ativo
	if(vol > 0)
	{
		request.volume       = vol;		                           
	}
	else
	{
		Print("Erro volume = 0");
		return (-2); 
	}



	// if(sl == 0)
	// {
	// 	sl = NULL;
	// }
	// if(tp == 0)
	// {
	// 	tp = NULL;
	// }
   
	// --- Preço de Stop Loss no caso de um movimento desfavorável de preço.	
	request.sl           = NormalizeDouble(sl, _Digits); 
	// --- Preço de Take Profit no caso de um movimento favorável de preço.
	request.tp           = NormalizeDouble(tp, _Digits);
	//-- O máximo desvio de preço, especificado em pontos
	request.deviation    = SELECTED_DEVIATION;                                       
	request.type         = orderType;                                       // Tipo da Ordem



	// https://www.mql5.com/pt/docs/constants/structures/mqltraderesult
	bool success=OrderSend(request,result);

	//--- se o resultado falha - tentar descobrir o porquê
	if(!success)
	{
			
      int answer=result.retcode;
      Print("TradeLog: Requisição de negociação falhou. Erro = ",GetLastError());
      switch(answer)
        {
         //--- nova cotação
         case 10004:
           {
            Print("TRADE_RETCODE_REQUOTE");
            Print("request.price = ",request.price,"   result.ask = ",
                  result.ask," result.bid = ",result.bid);
            break;
           }
         //--- ordem não é aceita pelo servidor
         case 10006:
           {
            Print("TRADE_RETCODE_REJECT");
            Print("request.price = ",request.price,"   result.ask = ",
                  result.ask," result.bid = ",result.bid);
            break;
           }
         //--- preço inválido
         case 10015:
           {
            Print("TRADE_RETCODE_INVALID_PRICE");
            Print("request.price = ",request.price,"   result.ask = ",
                  result.ask," result.bid = ",result.bid);
            break;
           }
         //--- SL e/ou TP inválidos
         case 10016:
           {
            Print("TRADE_RETCODE_INVALID_STOPS");
            Print("request.sl = ",request.sl," request.tp = ",request.tp);
            Print("result.ask = ",result.ask," result.bid = ",result.bid);
            break;
           }
         //--- volume inválido
         case 10014:
           {
            Print("TRADE_RETCODE_INVALID_VOLUME");
            Print("request.volume = ",request.volume,"   result.volume = ",
                  result.volume);
            break;
           }
         //--- sem dinheiro suficiente para uma operação de negociação
         case 10019:
           {
            Print("TRADE_RETCODE_NO_MONEY");
            Print("request.volume = ",request.volume,"   result.volume = ",
                  result.volume,"   result.comment = ",result.comment);
            break;
           }
         //--- alguma outra razão, saída com o código de resposta do servidor
         default:
           {
            Print("Outra resposta = ",answer);
           }
        }
      //--- notifica sobre o resultado sem sucesso da solicitação de negociação retornando false
      return(-1);
    }

	if(orderType == ORDER_TYPE_BUY_LIMIT ||orderType == ORDER_TYPE_BUY)
	{
		Deal_Current_Level_Buy = level;
	}
	else if(orderType == ORDER_TYPE_SELL_LIMIT ||orderType == ORDER_TYPE_SELL)
	{
		Deal_Current_Level_Sell = level;
	}
	my_last_deal = my_current_deal;
	my_current_deal = level;



	return (0);
}

double my_last_deal;
double my_current_deal;
double Deal_Current_Level_Sell;
double Deal_Current_Level_Buy;


void Place_Market_Order_Evo(int orderType, double level, double sl, double tp, double vol) // USING
{

	countOrdersSend += 1;
	countOrdersDeals +=1;

	countDayOrdersSend += 1;
	countDayOrdersDeals += 1;



	MqlTradeRequest request={};
	MqlTradeResult  result={0};
	ZeroMemory(request);
	ZeroMemory(result);

		request.action   	= TRADE_ACTION_DEAL; 
		//request.price       = SymbolInfoDouble(Symbol(), SYMBOL_BID); // Pode ser criada uma condicional para o bid não executar com spread alto.

    switch(DEAL_ORDER_TYPE_TIME)
    {
        case 0:
            request.type_filling = ORDER_FILLING_RETURN; 
            break;
        case 1:
			request.type_filling = ORDER_FILLING_FOK;
			break;
        case 2:
			request.type_filling = ORDER_FILLING_IOC;
			break;
        default:
            request.type_filling = ORDER_FILLING_RETURN; 
            break;
    }

    switch(DEAL_ORDER_TYPE_FILLING)
    {
        case 0:
            request.type_time    = ORDER_TIME_DAY;//ORDER_TIME_GTC; //ORDER_TIME_DAY; 
            break;
        case 1:
			request.type_time    = ORDER_TIME_GTC;//ORDER_TIME_GTC; //ORDER_TIME_DAY;
			break;
        default:
            request.type_time    = ORDER_TIME_DAY;//ORDER_TIME_GTC; //ORDER_TIME_DAY;
            break;
    }
	/*
	if(DEAL_ORDER_TYPE_TIME == 1)
	{
		request.type_filling = ORDER_FILLING_FOK; //ORDER_FILLING_FOK; //ORDER_FILLING_FOK		
	}
	else if(DEAL_ORDER_TYPE_TIME == 2)
	{
		request.type_filling = ORDER_FILLING_IOC;
	}
	else
	{
		request.type_filling = ORDER_FILLING_RETURN; 
	}
	*/	
	/*
	if(DEAL_ORDER_TYPE_FILLING == 1)
	{
		request.type_time    = ORDER_TIME_GTC;//ORDER_TIME_GTC; //ORDER_TIME_DAY;
	}
	else
	{	
		request.type_time    = ORDER_TIME_DAY;//ORDER_TIME_GTC; //ORDER_TIME_DAY;
	}
	*/

	//request.type_filling = ORDER_FILLING_RETURN; 
	//request.type_time    = ORDER_TIME_DAY;//ORDER_TIME_GTC; //ORDER_TIME_DAY;
	request.magic        = EXPERT_MAGIC;                  // Nº mágico da ordem
	request.symbol       = _Symbol;                       // Simbolo do ativo
	request.volume       = vol;                           // Nº de Lotes
   
   
	// --- Preço de Stop Loss no caso de um movimento desfavorável de preço.	
	request.sl           = NormalizeDouble(sl, _Digits); 
	// --- Preço de Take Profit no caso de um movimento favorável de preço.
	request.tp           = NormalizeDouble(tp, _Digits);
	//-- O máximo desvio de preço, especificado em pontos
	request.deviation    = SELECTED_DEVIATION;                                       
	request.type         = orderType;                                       // Tipo da Ordem



	// https://www.mql5.com/pt/docs/constants/structures/mqltraderesult
	bool success=OrderSend(request,result);

	//--- se o resultado falha - tentar descobrir o porquê
	if(!success)
	{
			
      int answer=result.retcode;
      Print("TradeLog: Requisição de negociação falhou. Erro = ",GetLastError());
      switch(answer)
        {
         //--- nova cotação
         case 10004:
           {
            Print("TRADE_RETCODE_REQUOTE");
            Print("request.price = ",request.price,"   result.ask = ",
                  result.ask," result.bid = ",result.bid);
            break;
           }
         //--- ordem não é aceita pelo servidor
         case 10006:
           {
            Print("TRADE_RETCODE_REJECT");
            Print("request.price = ",request.price,"   result.ask = ",
                  result.ask," result.bid = ",result.bid);
            break;
           }
         //--- preço inválido
         case 10015:
           {
            Print("TRADE_RETCODE_INVALID_PRICE");
            Print("request.price = ",request.price,"   result.ask = ",
                  result.ask," result.bid = ",result.bid);
            break;
           }
         //--- SL e/ou TP inválidos
         case 10016:
           {
            Print("TRADE_RETCODE_INVALID_STOPS");
            Print("request.sl = ",request.sl," request.tp = ",request.tp);
            Print("result.ask = ",result.ask," result.bid = ",result.bid);
            break;
           }
         //--- volume inválido
         case 10014:
           {
            Print("TRADE_RETCODE_INVALID_VOLUME");
            Print("request.volume = ",request.volume,"   result.volume = ",
                  result.volume);
            break;
           }
         //--- sem dinheiro suficiente para uma operação de negociação
         case 10019:
           {
            Print("TRADE_RETCODE_NO_MONEY");
            Print("request.volume = ",request.volume,"   result.volume = ",
                  result.volume,"   result.comment = ",result.comment);
            break;
           }
         //--- alguma outra razão, saída com o código de resposta do servidor
         default:
           {
            Print("Outra resposta = ",answer);
           }
        }

		if(orderType == ORDER_TYPE_BUY_LIMIT ||orderType == ORDER_TYPE_BUY)
		{
			Deal_Current_Level_Buy = level;
		}
		else if(orderType == ORDER_TYPE_SELL_LIMIT ||orderType == ORDER_TYPE_SELL)
		{
			Deal_Current_Level_Sell = level;
		}
		my_last_deal = my_current_deal;
		my_current_deal = level;		
      //--- notifica sobre o resultado sem sucesso da solicitação de negociação retornando false
      //return(false);
    }
}

int Place_Market_Order_Dev(int orderType, double level, double sl, double tp, double vol) // USING
{

	countOrdersSend += 1;
	countOrdersDeals +=1;

	countDayOrdersSend += 1;
	countDayOrdersDeals += 1;


	MqlTradeRequest request={};
	MqlTradeResult  result={0};
	ZeroMemory(request);
	ZeroMemory(result);

		request.action   	= TRADE_ACTION_DEAL; 
		//request.price       = SymbolInfoDouble(Symbol(), SYMBOL_BID); // Pode ser criada uma condicional para o bid não executar com spread alto.

    switch(DEAL_ORDER_TYPE_TIME)
    {
        case 0:
            request.type_filling = ORDER_FILLING_RETURN; 
            break;
        case 1:
			request.type_filling = ORDER_FILLING_FOK;
			break;
        case 2:
			request.type_filling = ORDER_FILLING_IOC;
			break;
        default:
            request.type_filling = ORDER_FILLING_RETURN; 
            break;
    }

    switch(DEAL_ORDER_TYPE_FILLING)
    {
        case 0:
            request.type_time    = ORDER_TIME_DAY;//ORDER_TIME_GTC; //ORDER_TIME_DAY; 
            break;
        case 1:
			request.type_time    = ORDER_TIME_GTC;//ORDER_TIME_GTC; //ORDER_TIME_DAY;
			break;
        default:
            request.type_time    = ORDER_TIME_DAY;//ORDER_TIME_GTC; //ORDER_TIME_DAY;
            break;
    }
	/*
	if(DEAL_ORDER_TYPE_TIME == 1)
	{
		request.type_filling = ORDER_FILLING_FOK; //ORDER_FILLING_FOK; //ORDER_FILLING_FOK		
	}
	else if(DEAL_ORDER_TYPE_TIME == 2)
	{
		request.type_filling = ORDER_FILLING_IOC;
	}
	else
	{
		request.type_filling = ORDER_FILLING_RETURN; 
	}
	*/	
	/*
	if(DEAL_ORDER_TYPE_FILLING == 1)
	{
		request.type_time    = ORDER_TIME_GTC;//ORDER_TIME_GTC; //ORDER_TIME_DAY;
	}
	else
	{	
		request.type_time    = ORDER_TIME_DAY;//ORDER_TIME_GTC; //ORDER_TIME_DAY;
	}
	*/

	//request.type_filling = ORDER_FILLING_RETURN; 
	//request.type_time    = ORDER_TIME_DAY;//ORDER_TIME_GTC; //ORDER_TIME_DAY;
	request.magic        = EXPERT_MAGIC;                  // Nº mágico da ordem
	request.symbol       = _Symbol;                       // Simbolo do ativo
	
   

		if(level > 0)
		{
			request.price 		 = NormalizeDouble(level, _Digits);
		}
		else
		{
			Print("Erro preço = 0");
			return (-3); 
		}



	if(vol > 0)
	{
		request.volume       = vol;		                           
	}
	else
	{
		Print("Erro volume = 0");
		return (-2); 
	}

   
	// --- Preço de Stop Loss no caso de um movimento desfavorável de preço.	
	request.sl           = NormalizeDouble(sl, _Digits); 
	// --- Preço de Take Profit no caso de um movimento favorável de preço.
	request.tp           = NormalizeDouble(tp, _Digits);
	//-- O máximo desvio de preço, especificado em pontos
	request.deviation    = SELECTED_DEVIATION;                                       
	request.type         = orderType;                                       // Tipo da Ordem



	// https://www.mql5.com/pt/docs/constants/structures/mqltraderesult
	bool success=OrderSend(request,result);

	//--- se o resultado falha - tentar descobrir o porquê
	if(!success)
	{
			
      int answer=result.retcode;
      Print("TradeLog: Requisição de negociação falhou. Erro = ",GetLastError());
      switch(answer)
        {
         //--- nova cotação
         case 10004:
           {
            Print("TRADE_RETCODE_REQUOTE");
            Print("request.price = ",request.price,"   result.ask = ",
                  result.ask," result.bid = ",result.bid);
            break;
           }
         //--- ordem não é aceita pelo servidor
         case 10006:
           {
            Print("TRADE_RETCODE_REJECT");
            Print("request.price = ",request.price,"   result.ask = ",
                  result.ask," result.bid = ",result.bid);
            break;
           }
         //--- preço inválido
         case 10015:
           {
            Print("TRADE_RETCODE_INVALID_PRICE");
            Print("request.price = ",request.price,"   result.ask = ",
                  result.ask," result.bid = ",result.bid);
            break;
           }
         //--- SL e/ou TP inválidos
         case 10016:
           {
            Print("TRADE_RETCODE_INVALID_STOPS");
            Print("request.sl = ",request.sl," request.tp = ",request.tp);
            Print("result.ask = ",result.ask," result.bid = ",result.bid);
            break;
           }
         //--- volume inválido
         case 10014:
           {
            Print("TRADE_RETCODE_INVALID_VOLUME");
            Print("request.volume = ",request.volume,"   result.volume = ",
                  result.volume);
            break;
           }
         //--- sem dinheiro suficiente para uma operação de negociação
         case 10019:
           {
            Print("TRADE_RETCODE_NO_MONEY");
            Print("request.volume = ",request.volume,"   result.volume = ",
                  result.volume,"   result.comment = ",result.comment);
            break;
           }
         //--- alguma outra razão, saída com o código de resposta do servidor
         default:
           {
            Print("Outra resposta = ",answer);
           }
        }
      //--- notifica sobre o resultado sem sucesso da solicitação de negociação retornando false
      return(-1);
    }
	if(orderType == ORDER_TYPE_BUY_LIMIT ||orderType == ORDER_TYPE_BUY)
	{
		Deal_Current_Level_Buy = level;
	}
	else if(orderType == ORDER_TYPE_SELL_LIMIT ||orderType == ORDER_TYPE_SELL)
	{
		Deal_Current_Level_Sell = level;
	}
	my_last_deal = my_current_deal;
	my_current_deal = level;
	return(0);
}




int total_deals_session()
{

	int acmOrdensExecutadas=0;
	HistorySelect(StringToTime(TimeToString(TimeTradeServer(), TIME_DATE)), INT_MAX);  // Seleciona histórico do dia
	int total = HistoryDealsTotal();
	for(int i = 0; i < total; i++)
	{
		ulong Ticket = HistoryDealGetTicket(i);
		if(HistoryDealGetString(Ticket, DEAL_SYMBOL) == _Symbol
			&& HistoryDealGetInteger(Ticket, DEAL_ENTRY) == DEAL_ENTRY_IN
			)
		{
			acmOrdensExecutadas++;
		}
	}
	//Comment("positionsFound " + acmOrdensExecutadas);  
	return(acmOrdensExecutadas);
}

//https://www.mql5.com/pt/forum/320590
// USED




int CountOrdersForPairType(int iType)
{
	int count = 0;
	  
	int orders_total = OrdersTotal();
	for(int i = 0; i < orders_total; i++)
	{
		if(OrderGetTicket(i) > 0) 
		{
            if((OrderGetString(ORDER_SYMBOL) == Symbol())
				//&& (OrderGetInteger(ORDER_MAGIC) == MAGIC_NUMBER)
				&& (OrderGetInteger(ORDER_TYPE) == iType))
			    {
					count++;
                }
        }          
	}
	//Print("count order: ", count);
	return count;	  
}

int TotalSymbolOrderBuyLimit;
int TotalSymbolOrderBuyStop;
int TotalSymbolOrderBuy;

int TotalSymbolOrderSellLimit;
int TotalSymbolOrderSellStop;
int TotalSymbolOrderSell;



void CountAllOrdersForPairType()
{


	TotalSymbolOrderBuyLimit = 0;
	TotalSymbolOrderBuyStop = 0;
	TotalSymbolOrderSellLimit = 0;
	TotalSymbolOrderSellStop = 0;
	  
	int orders_total = OrdersTotal();
	for(int i = 0; i < orders_total; i++)
	{
		if(OrderGetTicket(i) > 0) 
		{
            if(OrderGetString(ORDER_SYMBOL) == Symbol())
			{
				if(OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_BUY_LIMIT)
			    {
					TotalSymbolOrderBuyLimit ++;
                }
				else if(OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_BUY_STOP)
				{
					TotalSymbolOrderBuyStop ++;
				}
				else if(OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_SELL_LIMIT)
				{
					TotalSymbolOrderSellLimit ++;
				}
				else if(OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_SELL_STOP)
				{
					TotalSymbolOrderSellStop ++;
				}
			}
        }          
	}
		TotalSymbolOrderBuy = TotalSymbolOrderBuyLimit + TotalSymbolOrderBuyStop;
		TotalSymbolOrderSell = TotalSymbolOrderSellLimit + TotalSymbolOrderSellStop;

		//Print("TotalSymbolOrderBuy: ", TotalSymbolOrderBuy);
		//Print("TotalSymbolOrderSell: ", TotalSymbolOrderSell);

}

double CountVolOrdersForPairType(int iType)
{
	double count = 0;
	  
	int orders_total = OrdersTotal();
	for(int i = 0; i < orders_total; i++)
	{
		if(OrderGetTicket(i) > 0) 
		{
            if((OrderGetString(ORDER_SYMBOL) == Symbol())
				//&& (OrderGetInteger(ORDER_MAGIC) == MAGIC_NUMBER)
				&& (OrderGetInteger(ORDER_TYPE) == iType))
			    {
					count += OrderGetDouble(ORDER_VOLUME_CURRENT); 
                }
        }          
	}
	//Print("count order: ", count);
	return count;	  
}

double GetCountVolByOrders_BuyType()
{
	double count = 0;
	{
		count = CountVolOrdersForPairType(ORDER_TYPE_BUY_LIMIT) + CountVolOrdersForPairType(ORDER_TYPE_BUY_STOP);
	}
	return count;

}

double GetCountVolByOrders_SellType()
{
	double count = 0;
	{
		count = CountVolOrdersForPairType(ORDER_TYPE_SELL_LIMIT) + CountVolOrdersForPairType(ORDER_TYPE_SELL_STOP);
	}
	return count;

}

int GetCountOrders_BuyType()
{
	int count = 0;
	{
		count = CountOrdersForPairType(ORDER_TYPE_BUY_LIMIT) + CountOrdersForPairType(ORDER_TYPE_BUY_STOP);
	}
	return count;

}

int GetCountOrders_SellType()
{
	int count = 0;
	{
		count = CountOrdersForPairType(ORDER_TYPE_SELL_LIMIT) + CountOrdersForPairType(ORDER_TYPE_SELL_STOP);
	}
	return count;

}



int CountOrdersByType(string order_type, string symbol)
{
	//--- é necessário otimizar a função removendo o que não importa
	int count = 0;
	if (symbol == _Symbol)
	{
	
//--- variáveis ​​para retornar valores das propriedades de ordem
	   ulong    ticket;
	   //double   open_price;
	   //double   initial_volume;
	   //datetime time_setup;
	   //string   symbol;
	   string   type;
	   //long     order_magic;
	   //long     positionID;
	//--- Numero de ordens atuais pendentes
	   uint     total=OrdersTotal();
	   
	//--- passar por ordens em um loop
	   for(uint i=0;i<total;i++)
		 {
		  //--- voltar ticket ordem por sua posição na lista
			if((ticket=OrderGetTicket(i))>0)
			{
				
				//type          = EnumToString(ENUM_ORDER_TYPE(OrderGetInteger(ORDER_TYPE)));
				//order_type    = EnumToString(ENUM_ORDER_TYPE(OrderGetInteger(order_type)));
				type          = (ENUM_ORDER_TYPE(OrderGetInteger(ORDER_TYPE)));
				
				//Print("CountOrdersByType type" + type);
				//Print("order_type type" + order_type);			 
				if(order_type == type)
				{
					count = count +1;
				}			   
				 
				 
				 //--- preparar e apresentar informações sobre a ordem
				 /*printf("#ticket %d %s %G %s em %G foi criado em %s",
						ticket,                 // ticket de ordem
						type,                   // tipo
						initial_volume,         // volume colocado
						symbol,                 // simbolo
						open_price,             // preço de abertura especificada
						TimeToString(time_setup)// tempo de colocar a ordem
						);*/
			}
		 }
	}
	
	return count;
	
}

int UpdateOrderByType(string order_type, double level, double vol)
{
	//--- é necessário otimizar a função removendo o que não importa
	int count = 0;
		//--- variáveis ​​para retornar valores das propriedades de ordem
	ulong    ticket;
	   //double   open_price;
	   //double   initial_volume;
	   //datetime time_setup;
	   //string   symbol;
	string   type;
	   //long     order_magic;
	   //long     positionID;
	//--- Numero de ordens atuais pendentes
	uint     total=OrdersTotal();
	   
	//--- passar por ordens em um loop
	for(uint i=0;i<total;i++)
		{
		//--- voltar ticket ordem por sua posição na lista
		if((ticket=OrderGetTicket(i))>0)
		{

				if(OrderGetString(ORDER_SYMBOL) == Symbol())
				{
					type          = (ENUM_ORDER_TYPE(OrderGetInteger(ORDER_TYPE)));
				

					//Print("CountOrdersByType type" + type);
				//type          = EnumToString(ENUM_ORDER_TYPE(OrderGetInteger(ORDER_TYPE)));
				//order_type    = EnumToString(ENUM_ORDER_TYPE(OrderGetInteger(order_type)));
				
				//Print("CountOrdersByType type" + type);
				//Print("order_type type" + order_type);			 
				if(order_type == type)
				{
					trade.OrderDelete(OrderGetTicket(i));
					countOrdersCancel +=1;
					countOrdersDeals +=1;

					countDayOrdersCancel += 1;
					countDayOrdersDeals += 1;



					int r = Place_Order_Dev(ENUM_ORDER_TYPE(OrderGetInteger(ORDER_TYPE)), level, NULL , NULL, vol);
					count = count +1;
					if(order_type == ORDER_TYPE_BUY_LIMIT)
					{
						Deal_Current_Level_Buy = level;
					}
					else
					{
						Deal_Current_Level_Sell = level;
					}
					
					return  (1); // caso a lógica permita mais de uma ordem esse return precisa ser removido deste local.
				}			   
			}

		}
	}
	return (0);
}




//USING

// vai cancelar ordens de outros pares
void CancelAllOrders()
{


		for (int i = OrdersTotal() - 1; i >= 0; i--)
		{
			ulong OrderTicket = OrderGetTicket(i);
			trade.OrderDelete(OrderTicket);  
		}
	
}

//+------------------------------------------------------------------+
//| EXANGE CANCEL ORDERS (USING)                                     |
//+------------------------------------------------------------------+

// remove todas as ordens pendentes do ativo
void CancelAllOrdersByExchange() // 
{
	
		//Print("CancelAllOrdersByExchange");
		for(int i = OrdersTotal() - 1; i >= 0; i--)
		{
			if(OrderGetTicket(i) > 0)
			{
				if(OrderGetString(ORDER_SYMBOL) == Symbol())
				{				
					ulong OrderTicket = OrderGetTicket(i);
					trade.OrderDelete(OrderTicket);  
				}
			}
		}
		
	
}

bool CancelAllOrdersByExchange_v1() // USING
{

	for(int i = OrdersTotal() - 1; i >= 0; i--)
	{
		if(OrderGetTicket(i) > 0)
		{
			//if((OrderGetString(ORDER_SYMBOL) == THIS_SYMBOL))
			if(OrderGetString(ORDER_SYMBOL) == Symbol())
			{
				//&& (OrderGetInteger(ORDER_MAGIC) == m_magic)) {
				MqlTradeRequest request = {};
				MqlTradeResult result = {0};
				request.action = TRADE_ACTION_REMOVE; // comando que remove as ordens, uma a uma.
				request.order = OrderGetTicket(i);
				if(!OrderSend(request, result))
				{
					PrintFormat("CheckCloseAll - remove order - ",
					__FUNCTION__, ": OrderSend error %d", GetLastError());
				}      
				ZeroMemory(request);
				ZeroMemory(result);
			}
		}
	}


	return true; 
}

bool CancelAllThisSymbolOrders() // USING
{

	for(int i = OrdersTotal() - 1; i >= 0; i--)
	{
		if(OrderGetTicket(i) > 0)
		{
			//if((OrderGetString(ORDER_SYMBOL) == THIS_SYMBOL))
			if(OrderGetString(ORDER_SYMBOL) == Symbol())
			{
				//&& (OrderGetInteger(ORDER_MAGIC) == m_magic)) {
				MqlTradeRequest request = {};
				MqlTradeResult result = {0};
				request.action = TRADE_ACTION_REMOVE; // comando que remove as ordens, uma a uma.
				request.order = OrderGetTicket(i);
				if(!OrderSend(request, result))
				{
					PrintFormat("CheckCloseAll - remove order - ",
					__FUNCTION__, ": OrderSend error %d", GetLastError());
				}      
				ZeroMemory(request);
				ZeroMemory(result);
			}
		}
	}


	return true; 
}


//+------------------------------------------------------------------+
//| CLOSING POSITIONS                                                     
//+------------------------------------------------------------------+
/*
void CloseAllPositions()
{
	if(THIS_SYMBOL == _Symbol)
	{
		//Print("CloseAllPositions");
		for (int i = PositionsTotal() - 1; i >= 0; i--)
		{

		}
	}
}
*/





void CloseAllPositions()
{
	int countAllPositions = 0;
	int countThisPosition = 0;
		
	for (int i = PositionsTotal() - 1; i >= 0; i--)
	{
		countAllPositions += 1;
		if(PositionSelect(_Symbol))//THIS_SYMBOL == _Symbol)
		{
			int PositionTicket = PositionGetTicket(i);
			
			trade.PositionClose(PositionTicket);
			countThisPosition += 1;
		}
	}
}

void CloseAllThisSymbolPosition()
{
	int countAllPositions = 0;
	int countThisPosition = 0;
		
	for (int i = PositionsTotal() - 1; i >= 0; i--)
	{
		countAllPositions += 1;
		if(PositionSelect(_Symbol))//THIS_SYMBOL == _Symbol)
		{
			if(PositionGetString(POSITION_SYMBOL) == Symbol())
			{
				int PositionTicket = PositionGetTicket(i);
				trade.PositionClose(PositionTicket);
				countThisPosition += 1;
			}
		}
	}
}





void CancelBuyOrders(string symbol, string callFrom)
{
	string   type;		

	

	for(int i = OrdersTotal() - 1; i >= 0; i--)
	{
		if(OrderGetTicket(i) > 0)
		{
			//if((OrderGetString(ORDER_SYMBOL) == THIS_SYMBOL))
			if(OrderGetString(ORDER_SYMBOL) == Symbol())
			{					

				type = EnumToString(ENUM_ORDER_TYPE(OrderGetInteger(ORDER_TYPE)));	
				
				if(type == "ORDER_TYPE_BUY_STOP" || type == "ORDER_TYPE_BUY_LIMIT")
				{
					//trade.OrderDelete(OrderGetTicket(i));
					//Print("CancelBuyOrders- call from -> ", callFrom);

				MqlTradeRequest request = {};
				MqlTradeResult result = {0};
				request.action = TRADE_ACTION_REMOVE; // comando que remove as ordens, uma a uma.
				request.order = OrderGetTicket(i);
				if(!OrderSend(request, result))
				{
					PrintFormat("CheckCloseAll - remove order - ",
					__FUNCTION__, ": OrderSend error %d", GetLastError());
				}      
				ZeroMemory(request);
				ZeroMemory(result);




				}


			}
		}
	}
}

void CancelSellOrders(string symbol, string callFrom)
{
	string   type;
	for(int i = OrdersTotal() - 1; i >= 0; i--)
	{
		if(OrderGetTicket(i) > 0)
		{
			//if((OrderGetString(ORDER_SYMBOL) == THIS_SYMBOL))
			if(OrderGetString(ORDER_SYMBOL) == Symbol())
			{					
				type = EnumToString(ENUM_ORDER_TYPE(OrderGetInteger(ORDER_TYPE)));
				
				if(type == "ORDER_TYPE_SELL_STOP" || type == "ORDER_TYPE_SELL_LIMIT")
				{
					//trade.OrderDelete(OrderGetTicket(i));
					//Print("CancelSellOrders - call from -> ", callFrom);
				

					MqlTradeRequest request = {};
					MqlTradeResult result = {0};
					request.action = TRADE_ACTION_REMOVE; // comando que remove as ordens, uma a uma.
					request.order = OrderGetTicket(i);
					if(!OrderSend(request, result))
					{
						PrintFormat("CheckCloseAll - remove order - ",
						__FUNCTION__, ": OrderSend error %d", GetLastError());
					}      
					ZeroMemory(request);
					ZeroMemory(result);

				}


			}
		}
	}
}

void CancelOrderBySide(string order_type, string symbol)
{
	string   type;
	

	for(int i = OrdersTotal() - 1; i >= 0; i--)
	{
		if(OrderGetTicket(i) > 0)
		{
			//if((OrderGetString(ORDER_SYMBOL) == THIS_SYMBOL))
			if(OrderGetString(ORDER_SYMBOL) == Symbol())
			{					

				type          			= EnumToString(ENUM_ORDER_TYPE(OrderGetInteger(ORDER_TYPE)));
				
				if(order_type == type)
				{
					trade.OrderDelete(OrderGetTicket(i));
					Print("CancelOrderBySide");
					/*
					MqlTradeRequest request = {};
					MqlTradeResult result = {0};
					request.action = TRADE_ACTION_REMOVE; // comando que remove as ordens, uma a uma.
					request.order = OrderGetTicket(i);
					if(!OrderSend(request, result))
					{
						PrintFormat("CheckCloseAll - remove order - ",
						__FUNCTION__, ": OrderSend error %d", GetLastError());
					}      
					ZeroMemory(request);
					ZeroMemory(result);
					*/
				}


			}
		}
	}
}

	//return true; 

void CancelOrderByType(string order_type, string symbol)
{
	string   type;
	
	for(int i = OrdersTotal() - 1; i >= 0; i--)
	{
		if(OrderGetTicket(i) > 0)
		{
			//if((OrderGetString(ORDER_SYMBOL) == THIS_SYMBOL))
			if(OrderGetString(ORDER_SYMBOL) == Symbol())
			{					

				type          			= EnumToString(ENUM_ORDER_TYPE(OrderGetInteger(ORDER_TYPE)));
				
				if(order_type == type)
				{
					trade.OrderDelete(OrderGetTicket(i));
					/*
					MqlTradeRequest request = {};
					MqlTradeResult result = {0};
					request.action = TRADE_ACTION_REMOVE; // comando que remove as ordens, uma a uma.
					request.order = OrderGetTicket(i);
					if(!OrderSend(request, result))
					{
						PrintFormat("CheckCloseAll - remove order - ",
						__FUNCTION__, ": OrderSend error %d", GetLastError());
					}      
					ZeroMemory(request);
					ZeroMemory(result);
					*/
				}


			}
		}
	}


}






//+------------------------------------------------------------------+
//| EXANGE MODIFY POSITIONS                              |
//+------------------------------------------------------------------+

void ModifyPositions(double price, double SL, double TP, ENUM_POSITION_TYPE side) 
{
//--- declaracão do pedido e o seu resultado
   MqlTradeRequest request;
   MqlTradeResult  result;
   int total=PositionsTotal(); // número de posições abertas   
//--- iterar sobre todas as posições abertas
	for(int i=0; i<total; i++)
	{
		string position_symbol=PositionGetString(POSITION_SYMBOL); // símbolo 
		//if(position_symbol == THIS_SYMBOL)
		if(PositionGetString(POSITION_SYMBOL) == Symbol())
		{

			//--- parâmetros da ordem
			ulong  position_ticket=PositionGetTicket(i);// bilhete da posição
			int    digits=(int)SymbolInfoInteger(position_symbol,SYMBOL_DIGITS); // número de signos depois da coma
			ulong  magic=PositionGetInteger(POSITION_MAGIC); // MagicNumber da posição
			double volume=PositionGetDouble(POSITION_VOLUME);    // volume da posição
			double sl=PositionGetDouble(POSITION_SL);  // Stop Loss da posição
			double tp=PositionGetDouble(POSITION_TP);  // Take-Profit da posição
			ENUM_POSITION_TYPE type=(ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);  // tipo da posição
			//--- saída de informações sobre a posição
			PrintFormat("#%I64u %s  %s  %.2f  %s  sl: %s  tp: %s  [%I64d]",
						position_ticket,
						position_symbol,
						EnumToString(type),
						volume,
						DoubleToString(PositionGetDouble(POSITION_PRICE_OPEN),digits),
						DoubleToString(sl,digits),
						DoubleToString(tp,digits),
						magic);
			//--- se o MagicNumber coincidir, o Stop-Loss e o Take-Profit não estão definidos
			
			if (side == type)
			{
				if(magic==MagicNumber)// && sl==0 && tp==0)
				{ 
					//--- cálculo dos níveis de preços atuais
					double price=PositionGetDouble(POSITION_PRICE_OPEN);
					double bid=SymbolInfoDouble(position_symbol,SYMBOL_BID);
					double ask=SymbolInfoDouble(position_symbol,SYMBOL_ASK);
					
					int    stop_level=(int)SymbolInfoInteger(position_symbol,SYMBOL_TRADE_STOPS_LEVEL);
					double price_level;
					//--- se o nível de deslocamento mínimo permitido em pontos a partir do preço atual de fechamento não estiver definido
					if(stop_level<=0)
					stop_level=110; // definimos o deslocamento em 150 pontos a partir do preço atual de fechamento
					else
					stop_level+=50; // definimos o nível de deslocamento (SYMBOL_TRADE_STOPS_LEVEL + 50) pontos para a confiabilidade
			
					//--- cálculo e arredondamento dos valores Stop-Loss e Take-Profit
					price_level=stop_level*SymbolInfoDouble(position_symbol,SYMBOL_POINT);
					if(type==POSITION_TYPE_BUY)
					{
					sl=NormalizeDouble(bid-price_level,digits);
					tp=NormalizeDouble(ask+price_level,digits);
					}
					else
					{
					sl=NormalizeDouble(ask+price_level,digits);
					tp=NormalizeDouble(bid-price_level,digits);
					}
					//--- zerar os valores de pedido e o seu resultado
					ZeroMemory(request);
					ZeroMemory(result);
					//--- definição dos parâmetros de operação
					request.action  =TRADE_ACTION_SLTP; // tipo de operação de negociação
					request.position=position_ticket;   // bilhete da posição
					request.symbol=position_symbol;     // símbolo 
					request.sl      = NormalizeDouble(SL,digits);                // Stop Loss da posição
					request.tp      = NormalizeDouble(TP,digits);                // Take Profit da posição
					request.magic=MagicNumber;         // MagicNumber da posição
					
					Print("OIA");
					//--- saída de informações sobre a modificação
					PrintFormat("Modify #%I64d %s %s",position_ticket,position_symbol,EnumToString(type));
					//--- envio do pedido
					if(!OrderSend(request,result))
					PrintFormat("OrderSend error %d",GetLastError());  // se não for possível enviar o pedido, exibir o código de erro
					//--- informações sobre a operação   
					PrintFormat("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);
					Print("EITA");
				}
			}
		}
	}
}

void ModifyPositionsEvo(double SL, double TP, ENUM_POSITION_TYPE side) // USING
{
//--- declaracão do pedido e o seu resultado
   MqlTradeRequest request;
   MqlTradeResult  result;
   //int total=PositionsTotal(); // número de posições abertas   
//--- iterar sobre todas as posições abertas
	for(int i=0; i<PositionsTotal(); i++)
	{
		string position_symbol=PositionGetString(POSITION_SYMBOL); // símbolo 
		//if(position_symbol == THIS_SYMBOL)
		if(PositionGetString(POSITION_SYMBOL) == Symbol())
		{
			ulong  position_ticket=PositionGetTicket(i);// bilhete da posição
			ENUM_POSITION_TYPE type=(ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);  // tipo da posição
			if (side == type)
			{
					ZeroMemory(request);
					ZeroMemory(result);
					//--- definição dos parâmetros de operação
					request.action  = TRADE_ACTION_SLTP; // tipo de operação de negociação
					request.position=position_ticket;   // bilhete da posição
					request.symbol=position_symbol;     // símbolo 
					if(SL != NULL)
						request.sl      = NormalizeDouble(SL, _Digits);                // Stop Loss da posição
					if(TP != NULL)
						request.tp      = NormalizeDouble(TP, _Digits);                // Take Profit da posição
					request.magic=MagicNumber;         // MagicNumber da posição
					
					Print("ModifyPositionsEvo");
					//--- saída de informações sobre a modificação
					PrintFormat("Modify #%I64d %s %s",position_ticket,position_symbol,EnumToString(type));
					//--- envio do pedido
					if(!OrderSend(request,result))
					PrintFormat("OrderSend error %d",GetLastError());  // se não for possível enviar o pedido, exibir o código de erro
					//--- informações sobre a operação   
					PrintFormat("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);
			}
			break;
		}
	}
}




void Modify_SL_TP(double SL, double TP) // USING
{
//--- declaracão do pedido e o seu resultado
   MqlTradeRequest request;
   MqlTradeResult  result;
	
	ZeroMemory(request);
	ZeroMemory(result);
	
	
	
	for(int i=0; i<PositionsTotal(); i++)
	{
		string position_symbol=PositionGetString(POSITION_SYMBOL); // símbolo 
		//if(position_symbol == THIS_SYMBOL)
		if(PositionGetString(POSITION_SYMBOL) == Symbol())
		{
			ulong  position_ticket=PositionGetTicket(i);// bilhete da posição
			
			//--- definição dos parâmetros de operação
			request.action  = TRADE_ACTION_SLTP; // tipo de operação de negociação
			request.position=position_ticket;   // bilhete da posição
			request.symbol=position_symbol;     // símbolo 
			if(SL != NULL)
			{
				//request.sl      = NormalizeDouble(SL, _Digits);                // Stop Loss da posição
				request.sl      = NormalizeDouble(MyRound(SL), _Digits);                // Stop Loss da posição

			}
			if(TP != NULL)
			{
				request.tp      = NormalizeDouble(MyRound(TP), _Digits);                // Take Profit da posição
			}
			
			
			request.magic=MagicNumber;         // MagicNumber da posição
			

			Print("Modify_SL_TP");
			//--- saída de informações sobre a modificação
			PrintFormat("Modify #%I64d %s ",position_ticket,position_symbol);
			//--- envio do pedido
			if(!OrderSend(request,result))
			PrintFormat("OrderSend error %d",GetLastError());  // se não for possível enviar o pedido, exibir o código de erro
			//--- informações sobre a operação   
			PrintFormat("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);
			
			
		}
	}
}
void Modify_SL(double SL) // USING
{
//--- declaracão do pedido e o seu resultado
   MqlTradeRequest request;
   MqlTradeResult  result;
	
	ZeroMemory(request);
	ZeroMemory(result);
	
	for(int i=0; i<PositionsTotal(); i++)
	{
		string position_symbol=PositionGetString(POSITION_SYMBOL); // símbolo 
		//if(position_symbol == THIS_SYMBOL)
		if(PositionGetString(POSITION_SYMBOL) == Symbol())
		{
			ulong  position_ticket=PositionGetTicket(i);// bilhete da posição
			
			//--- definição dos parâmetros de operação
			request.action  = TRADE_ACTION_SLTP; // tipo de operação de negociação
			request.position=position_ticket;   // bilhete da posição
			request.symbol=position_symbol;     // símbolo 
			if(SL != NULL)
			{
				//request.sl      = NormalizeDouble(SL, _Digits);                // Stop Loss da posição
				request.sl      = NormalizeDouble(MyRound(SL), _Digits);                // Stop Loss da posição
			}
             // Take Profit da posição
			
			
			request.magic=MagicNumber;         // MagicNumber da posição
			

			Print("Modify_SL");
			Print("Modify_SL", SL);
			//--- saída de informações sobre a modificação
			PrintFormat("Modify #%I64d %s ",position_ticket,position_symbol);
			//--- envio do pedido
			if(!OrderSend(request,result))
			PrintFormat("OrderSend error %d",GetLastError());  // se não for possível enviar o pedido, exibir o código de erro
			//--- informações sobre a operação   
			PrintFormat("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);
			
			
		}
	}
}

void Modify_TP(double TP) // USING
{
//--- declaracão do pedido e o seu resultado
   MqlTradeRequest request;
   MqlTradeResult  result;
	
	ZeroMemory(request);
	ZeroMemory(result);
	
	
	
	for(int i=0; i<PositionsTotal(); i++)
	{
		string position_symbol=PositionGetString(POSITION_SYMBOL); // símbolo 
		//if(position_symbol == THIS_SYMBOL)
		if(PositionGetString(POSITION_SYMBOL) == Symbol())
		{
			ulong  position_ticket=PositionGetTicket(i);// bilhete da posição
			
			//--- definição dos parâmetros de operação
			request.action  = TRADE_ACTION_SLTP; // tipo de operação de negociação
			request.position=position_ticket;   // bilhete da posição
			request.symbol=position_symbol;     // símbolo 

			if(TP != NULL)
			{
				request.tp      = NormalizeDouble(MyRound(TP), _Digits);                // Take Profit da posição
			}
			
			
			request.magic=MagicNumber;         // MagicNumber da posição
			

			Print("Modify_TP");
			Print("Modify_TP", TP);
			//--- saída de informações sobre a modificação
			PrintFormat("Modify #%I64d %s ",position_ticket,position_symbol);
			//--- envio do pedido
			if(!OrderSend(request,result))
			PrintFormat("OrderSend error %d",GetLastError());  // se não for possível enviar o pedido, exibir o código de erro
			//--- informações sobre a operação   
			PrintFormat("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);
			
			
		}
	}
}
//+------------------------------------------------------------------+
//| Modificação de ordens pendentes                                  |
//+------------------------------------------------------------------+
void Modify_Orders_Action(double SL, double TP, ENUM_POSITION_TYPE side, double price)
{
	//-- declaração e inicialização do pedido e o seu resultado
	MqlTradeRequest request={};
	MqlTradeResult result={0};
	int total=OrdersTotal(); // número de ordens pendentes colocadas
	//--- iterar todas as ordens pendentes colocadas
	
	for(int i=0; i<total; i++)
	{

		string position_symbol=PositionGetString(POSITION_SYMBOL); // símbolo 
		//if(position_symbol == THIS_SYMBOL)
		if(PositionGetString(POSITION_SYMBOL) == Symbol())
		{
			ENUM_POSITION_TYPE type=(ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);  // tipo da posição
			if (side == type)
			{			
				//--- parâmetros da ordem
				//ulong order_ticket=OrderGetTicket(i); // bilhete da ordem
				
				
				ulong magic=OrderGetInteger(ORDER_MAGIC); // MagicNumber da ordem
				//--- se o MagicNumber coincidir, o Stop Loss e o Take Profit nao foram definidos
				if(magic==EXPERT_MAGIC)
				{
					if(SL == !NULL)
					{
						SL      = NormalizeDouble(MyRound(SL), _Digits);                // Stop Loss da posição
					}
					else
					{
						SL  = OrderGetDouble(ORDER_SL);
					}
					if(TP == !NULL)
					{
						TP      = NormalizeDouble(MyRound(TP), _Digits);                // Take Profit da posição
					}
					else
					{
						TP  = OrderGetDouble(ORDER_TP);
					}


					request.action=TRADE_ACTION_MODIFY; // tipo de operação de negociação
					request.order = OrderGetTicket(i); // bilhete da ordem
					request.symbol =Symbol(); // símbolo
					request.tp = TP;
					request.sl = SL;
					request.price = price;


					//--- envio do pedido
					if(!OrderSend(request,result))
					PrintFormat("OrderSend error %d",GetLastError()); // se não foi possível enviar o pedido, exibir o código de erro 
					//--- informações sobre a operação 
					PrintFormat("retcode=%u deal=%I64u order=%I64u",result.retcode,result.deal,result.order);
					//--- zerado dos valores do pedido e o seu resultado
					ZeroMemory(request);
					ZeroMemory(result);
				}
			}	
		}	
 	}
}
//+------------------------------------------------------------------+




/*
void OrderExecuted(ENUM_ORDER_TYPE def_order_type)
{
	
	
	
	if(def_order_type == ORDER_TYPE_BUY)
	{

	}
	else if(def_order_type == ORDER_TYPE_SELL)
	{

	}
	else if(def_order_type == ORDER_TYPE_BUY_LIMIT)
	{

	}
	else if(def_order_type == ORDER_TYPE_SELL_LIMIT)
	{

	}
	else if(def_order_type == ORDER_TYPE_BUY_STOP)
	{

	}
	else if(def_order_type == ORDER_TYPE_SELL_STOP)
	{

	}
	else if(def_order_type == ORDER_TYPE_BUY_STOP_LIMIT)
	{

	}
	else if(def_order_type == ORDER_TYPE_SELL_STOP_LIMIT)
	{

	}
	else if(def_order_type == ORDER_TYPE_CLOSE_BY)
	{

	}
	


}
*/

/*
enum enum_TYPE_ORDER 
{
    NONE                 = 0,
    order_AUTO_LONG  	 = 1,
    order_AUTO_SHORT	 = 2,
    order_LIMIT_LONG     = 3,
    order_LIMIT_SHORT    = 4

}; 

void Place_Order_Forex(int my_order_type, ENUM_ORDER_TYPE def_order_type, double level, double sl, double tp, double vol) // USING
{

	MqlTradeRequest request={};
	MqlTradeResult  result={0};
	ZeroMemory(request);
	ZeroMemory(result);
	
	ENUM_ORDER_TYPE orderType;
	
	
	
	//_______________________________________/_________________________________________
	
	
	//--- Identificação automática de tipo de ordem.
	if(my_order_type == order_AUTO_LONG)
	{
		if(level > SymbolInfoDouble(_Symbol, SYMBOL_ASK))
		{
			orderType = ORDER_TYPE_BUY_STOP;
		}
		else
		{
			orderType = ORDER_TYPE_BUY_LIMIT;
		}
	}
	else if (my_order_type == order_AUTO_SHORT)
	{
		if(level < SymbolInfoDouble(_Symbol, SYMBOL_BID))
		{
			orderType = ORDER_TYPE_SELL_STOP;
		}
		else
		{
			orderType = ORDER_TYPE_SELL_LIMIT;
		}
	}else
	{
		orderType = def_order_type;
	}
	
	
	
	
	//if (order_modify)	
		//request.order = x
	//		

   request.action       = TRADE_ACTION_PENDING;			//TRADE_ACTION_DEAL;                                     // Executa ordem a mercado
   request.magic        = EXPERT_MAGIC;                  // Nº mágico da ordem
   request.symbol       = _Symbol;                      // Simbolo do ativo
   request.volume       = vol;                          // Nº de Lotes
   
   
   request.price 		= NormalizeDouble(level, _Digits); 
   //request.price		= NormalizeDouble(round(level), _Digits);
   
	// --- Preço de Stop Loss no caso de um movimento desfavorável de preço.	
   request.sl           = NormalizeDouble(sl, _Digits); 
	// --- Preço de Take Profit no caso de um movimento favorável de preço.
   request.tp           = NormalizeDouble(tp, _Digits);
   //-- O máximo desvio de preço, especificado em pontos
   request.deviation    = DEVIATION;                                       
   request.type         = orderType;                                       // Tipo da Ordem
   request.type_filling = ORDER_FILLING_RETURN; //ORDER_FILLING_IOC; //ORDER_FILLING_FOK
   request.type_time    = ORDER_TIME_DAY; //ORDER_TIME_DAY;
   //request.datetime     = dt;
   
   /---
   OrderSend(request,result);
   //---
	if(result.retcode == 10008 || result.retcode == 10009)
       {
        //SHORT_POSITION = trade.RequestPrice();
        //Print("Ordem enviada com sucesso!");
        //Comment(" SHORT position "+ trade.RequestPrice());
        //SetPositionParms("short");
		//Print("numero da ordem!" + result.order);

       }
     else
       {
        Print("Erro ao enviar ordem. Erro = ", GetLastError());
        ResetLastError();
       }
	// https://www.mql5.com/pt/docs/constants/structures/mqltraderesult
	bool success=OrderSend(request,result);
	//--- se o resultado falha - tentar descobrir o porquê
	if(!success)
	{
		int answer = result.retcode;
		      Print("TradeLog: Requisição de negociação falhou. Erro = ",GetLastError());
      switch(answer)
        {
         //--- nova cotação
         case 10004:
           {
            Print("TRADE_RETCODE_REQUOTE");
            Print("request.price = ",request.price,"   result.ask = ",
                  result.ask," result.bid = ",result.bid);
            break;
           }
         //--- ordem não é aceita pelo servidor
         case 10006:
           {
            Print("TRADE_RETCODE_REJECT");
            Print("request.price = ",request.price,"   result.ask = ",
                  result.ask," result.bid = ",result.bid);
            break;
           }
         //--- preço inválido
         case 10015:
           {
            Print("TRADE_RETCODE_INVALID_PRICE");
            Print("request.price = ",request.price,"   result.ask = ",
                  result.ask," result.bid = ",result.bid);
            break;
           }
         //--- SL e/ou TP inválidos
         case 10016:
           {
            Print("TRADE_RETCODE_INVALID_STOPS");
            Print("request.sl = ",request.sl," request.tp = ",request.tp);
            Print("result.ask = ",result.ask," result.bid = ",result.bid);
            break;
           }
         //--- volume inválido
         case 10014:
           {
            Print("TRADE_RETCODE_INVALID_VOLUME");
            Print("request.volume = ",request.volume,"   result.volume = ",
                  result.volume);
            break;
           }
         //--- sem dinheiro suficiente para uma operação de negociação
         case 10019:
           {
            Print("TRADE_RETCODE_NO_MONEY");
            Print("request.volume = ",request.volume,"   result.volume = ",
                  result.volume,"   result.comment = ",result.comment);
            break;
           }
         //--- alguma outra razão, saída com o código de resposta do servidor
         default:
           {
            Print("Outra resposta = ",answer);
           }
        }
      //--- notifica sobre o resultado sem sucesso da solicitação de negociação retornando false
      //return(false);
	}
}

*/