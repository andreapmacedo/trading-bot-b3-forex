
#include "Orders_TP_Distance.mq5"
#include "Orders_SL_Distance.mq5"


void distanciaDoLevel(int chosen)
{
    switch(chosen)
    {
        case 0: 
            break;
        case 1:  // Distância por sequencia
            EN_STR_Distance_1();
            break;
        case 2:  // Distância por sequencia
            EN_STR_Distance_2();
            break;
        case 10:  // Distância por sequencia
            definirDistanciaDoLevel_cfg_10();
            break;
        case 11:  
            EstENOrerDst_11();
            break;
        case 20:  // Distância por sequencia e tendência
            EstENOrerDst_20();
            break;
        case 30:  // Distância por sequencia e trade status
            EstENOrerDst_30();
            break;
        case 100: 
            EstENOrerDst_100();
            break;
        case 50: // Distância por volume
            EstENOrerDst_50();
            break;
        case 51: 
            EstENOrerDst_51();
            break;
        case 52: 
            EstENOrerDst_52();
            break;
        case 1001: // independentes
            EstENOrerDst_01();
            break;
        case 1002: 
            EstENOrerDst_02();
            break;
        case 5010: // mistos
            EstENOrerDst_5010();
            break;
    }
}

void EN_STR_Distance_1()
{
    TopChange +=  SELECTED_EN_DISTANCE_LONG;
    BottomChange += SELECTED_EN_DISTANCE_SHORT;
}
void EN_STR_Distance_2()
{
    TopChange -=  SELECTED_EN_DISTANCE_LONG;
    BottomChange -= SELECTED_EN_DISTANCE_SHORT;
}


//+------------------------------------------------------------------+
// Distância por sequência
//+------------------------------------------------------------------+



void definirDistanciaDoLevel_cfg_10() //definirEstadoDoTrade_cfg_1
{
    double sequenciaMaximaDeEntradasEstabelecida;
    definirSequenciaMaximaDeEntradasEstabelecida(sequenciaMaximaDeEntradasEstabelecida);
    
    if(sequenciaDeEntradaNivelInferior > AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE)
    {
        double faixaDeOperacao;
        if(sequenciaDeEntradaNivelInferior <= sequenciaMaximaDeEntradasEstabelecida)
        {
            faixaDeOperacao = sequenciaDeEntradaNivelInferior-AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE;
        }
        else if(sequenciaDeEntradaNivelInferior > sequenciaMaximaDeEntradasEstabelecida)
        {
            faixaDeOperacao = sequenciaMaximaDeEntradasEstabelecida-AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE;
        }

        calcularAjusteDeDistanciaDoLevelInferior(AJUSTAR_DISTANCIA_POR_SEQUENCIA_MODO_PG, ajusteDeDistanciaPorSequencia, faixaDeOperacao);
    }
    else if(sequenciaDeEntradaNivelSuperior > AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE)   
    {
        double faixaDeOperacao;
        if(sequenciaDeEntradaNivelSuperior <= sequenciaMaximaDeEntradasEstabelecida)
        {
            faixaDeOperacao = sequenciaDeEntradaNivelSuperior-AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE;
        }
        else if(sequenciaDeEntradaNivelSuperior > sequenciaMaximaDeEntradasEstabelecida)
        {
            faixaDeOperacao = sequenciaMaximaDeEntradasEstabelecida-AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE;
        }
        calcularAjusteDeDistanciaDoLevelSuperior(AJUSTAR_DISTANCIA_POR_SEQUENCIA_MODO_PG, ajusteDeDistanciaPorSequencia, faixaDeOperacao);
    }
}



void EstENOrerDst_11() 
{
    double sequenciaMaximaDeEntradasEstabelecida;
    definirSequenciaMaximaDeEntradasEstabelecida(sequenciaMaximaDeEntradasEstabelecida);
    
    if(sequenciaDeEntradaNivelInferior > AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE)
    {
        double faixaDeOperacao;
        if(sequenciaDeEntradaNivelInferior <= sequenciaMaximaDeEntradasEstabelecida)
        {
            faixaDeOperacao = sequenciaDeEntradaNivelInferior-AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE;
        }
        else if(sequenciaDeEntradaNivelInferior > sequenciaMaximaDeEntradasEstabelecida)
        {
            faixaDeOperacao = sequenciaMaximaDeEntradasEstabelecida-AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE;
        }

        calcularAjusteDeDistanciaDoLevelInferior(AJUSTAR_DISTANCIA_POR_SEQUENCIA_MODO_PG, ajusteDeDistanciaPorSequencia, faixaDeOperacao);
        calcularAjusteDeDistanciaDoLevelSuperior(AJUSTAR_DISTANCIA_POR_SEQUENCIA_MODO_PG, ajusteDeDistanciaPorSequencia, faixaDeOperacao);
    }
    else if(sequenciaDeEntradaNivelSuperior > AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE)   
    {
        double faixaDeOperacao;
        if( sequenciaDeEntradaNivelSuperior <= sequenciaMaximaDeEntradasEstabelecida)
        {
            faixaDeOperacao = sequenciaDeEntradaNivelSuperior-AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE;
        }
        else if(sequenciaDeEntradaNivelSuperior > sequenciaMaximaDeEntradasEstabelecida)
        {
            faixaDeOperacao = sequenciaMaximaDeEntradasEstabelecida-AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE;
        }

        calcularAjusteDeDistanciaDoLevelInferior(AJUSTAR_DISTANCIA_POR_SEQUENCIA_MODO_PG, ajusteDeDistanciaPorSequencia, faixaDeOperacao);
        calcularAjusteDeDistanciaDoLevelSuperior(AJUSTAR_DISTANCIA_POR_SEQUENCIA_MODO_PG, ajusteDeDistanciaPorSequencia, faixaDeOperacao);
    }
}

void EstENOrerDst_20()
{
    /*
    -- Aplica o incremento de distancia na próxima entrada de acordo com a sequência de entradas consecutivas.
    -- Se aplica apenas ao lado da posição não atuando na ponta oposta.
    */
    double sequenciaMaximaDeEntradasEstabelecida;
    definirSequenciaMaximaDeEntradasEstabelecida(sequenciaMaximaDeEntradasEstabelecida);
    if(sequenciaDeEntradaNivelInferior > AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE && CurrentTrend == 1)
    {
        double faixaDeOperacao;
        if(sequenciaDeEntradaNivelInferior <= sequenciaMaximaDeEntradasEstabelecida)
        {
            faixaDeOperacao = sequenciaDeEntradaNivelInferior-AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE;
        }
        else if(sequenciaDeEntradaNivelInferior > sequenciaMaximaDeEntradasEstabelecida)
        {
            faixaDeOperacao = sequenciaMaximaDeEntradasEstabelecida-AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE;
        }
        calcularAjusteDeDistanciaDoLevelInferior(AJUSTAR_DISTANCIA_POR_SEQUENCIA_MODO_PG, ajusteDeDistanciaPorSequencia, faixaDeOperacao);
    }
    else if(sequenciaDeEntradaNivelSuperior > AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE && CurrentTrend == -1)   
    {
        double faixaDeOperacao;
        if(sequenciaDeEntradaNivelSuperior <= sequenciaMaximaDeEntradasEstabelecida)
        {
            faixaDeOperacao = sequenciaDeEntradaNivelSuperior-AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE;
        }
        else if(sequenciaDeEntradaNivelSuperior > sequenciaMaximaDeEntradasEstabelecida)
        {
            faixaDeOperacao = sequenciaMaximaDeEntradasEstabelecida-AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE;
        }
        calcularAjusteDeDistanciaDoLevelSuperior(AJUSTAR_DISTANCIA_POR_SEQUENCIA_MODO_PG, ajusteDeDistanciaPorSequencia, faixaDeOperacao);
    }
}
void EstENOrerDst_30()
{
    /*
    -- Aplica o incremento de distancia na próxima entrada de acordo com a sequência de entradas consecutivas.
    -- Se aplica apenas ao lado da posição não atuando na ponta oposta.
    */
    double sequenciaMaximaDeEntradasEstabelecida;
    definirSequenciaMaximaDeEntradasEstabelecida(sequenciaMaximaDeEntradasEstabelecida);
    if(sequenciaDeEntradaNivelInferior > AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE && atualEstadoSinteticoDoTrade == 2) // contra a tendência
    {
        double faixaDeOperacao;
        if(sequenciaDeEntradaNivelInferior <= sequenciaMaximaDeEntradasEstabelecida)
        {
            faixaDeOperacao = sequenciaDeEntradaNivelInferior-AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE;
        }
        else if(sequenciaDeEntradaNivelInferior > sequenciaMaximaDeEntradasEstabelecida)
        {
            faixaDeOperacao = sequenciaMaximaDeEntradasEstabelecida-AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE;
        }

        calcularAjusteDeDistanciaDoLevelInferior(AJUSTAR_DISTANCIA_POR_SEQUENCIA_MODO_PG, ajusteDeDistanciaPorSequencia, faixaDeOperacao);
    }
    else if(sequenciaDeEntradaNivelSuperior > AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE && atualEstadoSinteticoDoTrade == 2)   
    {
        double faixaDeOperacao;
        if(sequenciaDeEntradaNivelSuperior <= sequenciaMaximaDeEntradasEstabelecida)
        {
            faixaDeOperacao = sequenciaDeEntradaNivelSuperior-AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE;
        }
        else if(sequenciaDeEntradaNivelSuperior > sequenciaMaximaDeEntradasEstabelecida)
        {
            faixaDeOperacao = sequenciaMaximaDeEntradasEstabelecida-AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE;
        }
        calcularAjusteDeDistanciaDoLevelSuperior(AJUSTAR_DISTANCIA_POR_SEQUENCIA_MODO_PG, ajusteDeDistanciaPorSequencia, faixaDeOperacao);
    }
}


void EstENOrerDst_100()
{
    /*
    -- Aplica o incremento de distancia na próxima entrada de acordo com a sequência de entradas consecutivas.
    -- Se aplica apenas ao lado da posição não atuando na ponta oposta.
    */
    double sequenciaMaximaDeEntradasEstabelecida;
    definirSequenciaMaximaDeEntradasEstabelecida(sequenciaMaximaDeEntradasEstabelecida);
    if(sequenciaDeEntradaNivelInferior > AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE && pos_status == 0)
    {
        double faixaDeOperacao;
        if(sequenciaDeEntradaNivelInferior <= sequenciaMaximaDeEntradasEstabelecida)
        {
            faixaDeOperacao = sequenciaDeEntradaNivelInferior-AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE;
        }
        else if(sequenciaDeEntradaNivelInferior > sequenciaMaximaDeEntradasEstabelecida)
        {
            faixaDeOperacao = sequenciaMaximaDeEntradasEstabelecida-AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE;
        }

        calcularAjusteDeDistanciaDoLevelInferior(AJUSTAR_DISTANCIA_POR_SEQUENCIA_MODO_PG, ajusteDeDistanciaPorSequencia, faixaDeOperacao);
    }
    else if(sequenciaDeEntradaNivelSuperior > AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE && pos_status == 1)   
    {
        double faixaDeOperacao;
        if(sequenciaDeEntradaNivelSuperior <= sequenciaMaximaDeEntradasEstabelecida)
        {
            faixaDeOperacao = sequenciaDeEntradaNivelSuperior-AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE;
        }
        else if(sequenciaDeEntradaNivelSuperior > sequenciaMaximaDeEntradasEstabelecida)
        {
            faixaDeOperacao = sequenciaMaximaDeEntradasEstabelecida-AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE;
        }
        calcularAjusteDeDistanciaDoLevelSuperior(AJUSTAR_DISTANCIA_POR_SEQUENCIA_MODO_PG, ajusteDeDistanciaPorSequencia, faixaDeOperacao);
    }
}

//+------------------------------------------------------------------+
// Distância por volume
//+------------------------------------------------------------------+
void EstENOrerDst_50()
{
    /*
    -- incremento da distância pelo volume (apenas para lado contrário).
    */
    //Print("EstENOrerDst_50");
    double adj_end_vol;
    double ref_vol;
    
    SetAdjDstVolEnd(adj_end_vol);
    definirVolumeAtualEmLoteOuUnidade(ref_vol);

    

    if(ref_vol > AJUSTE_DE_DISTANCIA_POR_VOLUME_A_PARTIR_DE)
    {
        //double faixaDeOperacao = ref_vol-ajusteDeDistanciaPorVolumeAPartirDe;

        double faixaDeOperacao;
        if(ref_vol <= adj_end_vol)
        {
            faixaDeOperacao = ref_vol-ajusteDeDistanciaPorVolumeAPartirDe;
        }
        else if(ref_vol > adj_end_vol)
        {
            faixaDeOperacao = adj_end_vol-ajusteDeDistanciaPorVolumeAPartirDe;
        }


        if(pos_status == 0)
        {
            calcularAjusteDeDistanciaDoLevelInferior(AJUSTAR_DISTANCIA_POR_VOLUME_MODO_PG, ajusteDeDistanciaPorVolume, faixaDeOperacao);
        }
        if(pos_status == 1)
        {

            calcularAjusteDeDistanciaDoLevelSuperior(AJUSTAR_DISTANCIA_POR_VOLUME_MODO_PG, ajusteDeDistanciaPorVolume, faixaDeOperacao);
        }
    }
}

void EstENOrerDst_51()
{
    /*
    -- Aplica o incremento de distancia na próxima entrada de acordo com os lotes de volume incrementado.
    */
    
    double adj_end_vol;
    double ref_vol;
    
    SetAdjDstVolEnd(adj_end_vol);
    definirVolumeAtualEmLoteOuUnidade(ref_vol);

    //if(ref_vol > ajusteDeDistanciaPorVolumeAPartirDe && ref_vol <= adj_end_vol)
    if(ref_vol > ajusteDeDistanciaPorVolumeAPartirDe )
    {
        //double faixaDeOperacao = ref_vol-ajusteDeDistanciaPorVolumeAPartirDe;

        double faixaDeOperacao;
        if(ref_vol <= adj_end_vol)
        {
            faixaDeOperacao = ref_vol-ajusteDeDistanciaPorVolumeAPartirDe;
        }
        else if(ref_vol > adj_end_vol)
        {
            faixaDeOperacao = adj_end_vol-ajusteDeDistanciaPorVolumeAPartirDe;
        }



        calcularAjusteDeDistanciaDoLevelInferior(AJUSTAR_DISTANCIA_POR_VOLUME_MODO_PG, ajusteDeDistanciaPorVolume, faixaDeOperacao);
        calcularAjusteDeDistanciaDoLevelSuperior(AJUSTAR_DISTANCIA_POR_VOLUME_MODO_PG, ajusteDeDistanciaPorVolume, faixaDeOperacao);

    }
}
void EstENOrerDst_52()
{
    /*
    -- Aplica o incremento de distancia na próxima entrada de acordo com os lotes de volume incrementado.
    */
    
    double adj_end_vol;
    double ref_vol;
    
    SetAdjDstVolEnd(adj_end_vol);
    definirVolumeAtualEmLoteOuUnidade(ref_vol);
    //double faixaDeOperacao = ref_vol-ajusteDeDistanciaPorVolumeAPartirDe;


    double faixaDeOperacao;
    if(ref_vol <= adj_end_vol)
    {
        faixaDeOperacao = ref_vol-ajusteDeDistanciaPorVolumeAPartirDe;
    }
    else if(ref_vol > adj_end_vol)
    {
        faixaDeOperacao = adj_end_vol-ajusteDeDistanciaPorVolumeAPartirDe;
    }

    if(ref_vol > AJUSTE_DE_DISTANCIA_POR_VOLUME_A_PARTIR_DE && ref_vol <= adj_end_vol)
    {


        if(pos_status == 0)
        {
            calcularAjusteDeDistanciaDoLevelInferior(true, ajusteDeDistanciaPorVolume, faixaDeOperacao);
            calcularAjusteDeDistanciaDoLevelSuperior(false, ajusteDeDistanciaPorVolume, faixaDeOperacao);
        }
        if(pos_status == 1)
        {

            calcularAjusteDeDistanciaDoLevelInferior(false, ajusteDeDistanciaPorVolume, faixaDeOperacao);
            calcularAjusteDeDistanciaDoLevelSuperior(true, ajusteDeDistanciaPorVolume, faixaDeOperacao);
        }
    }
    else if(ref_vol > AJUSTE_DE_DISTANCIA_POR_VOLUME_A_PARTIR_DE && ref_vol > adj_end_vol)
    {
        if(pos_status == 0)
        {
            calcularAjusteDeDistanciaDoLevelInferior(true, ajusteDeDistanciaPorVolume, faixaDeOperacao);   
        }
        if(pos_status == 1)
        {
            calcularAjusteDeDistanciaDoLevelSuperior(true, ajusteDeDistanciaPorVolume, faixaDeOperacao);
        }               
    }
}


void calcularAjusteDeDistanciaDoLevelInferior(double mode_pg, double selected_adj, double faixaDeOperacao)
{
    if(mode_pg)
    {
        BottomChange  += SetSimplePGMode(selected_adj, faixaDeOperacao);
        //definirAjusteNivelInferiorDaOrdem(SetSimplePGMode(selected_adj, faixaDeOperacao));
        aumentarNivelInferiorDaOrdem(SetSimplePGMode(selected_adj, faixaDeOperacao));
    }
    else
    {
        BottomChange  += selected_adj * faixaDeOperacao;
        //definirAjusteNivelInferiorDaOrdem(selected_adj * faixaDeOperacao);
        aumentarNivelInferiorDaOrdem(selected_adj * faixaDeOperacao);
    }
        //+------------------------------------------------------------------+
        // Temporário
        //+------------------------------------------------------------------+	
        // Módulo temporário para comparação de variáveis de reetruturação do código

        if(Level_Sell != nivelSuperiorDaOrdem){
            Print("Inconsistência no level superior - calcularAjusteDeDistanciaDoLevelInferior!");
            Print("Level_Sell -> ", Level_Sell);
            Print("nivelSuperiorDaOrdem -> ", nivelSuperiorDaOrdem);

        }

        if(Level_Buy != nivelInferiorDaOrdem){

            Print("Inconsistência no level inferior - calcularAjusteDeDistanciaDoLevelInferior!");
            Print("Level_Buy -> ", Level_Buy);
            Print("nivelInferiorDaOrdem -> ", nivelInferiorDaOrdem);

        }

}
void SetDistanceBottomChange_evo(double mode_pg, double selected_adj, double start, double end)
{
    double faixaDeOperacao;
    if(end > start)
    {
        faixaDeOperacao = end - start;
    } 
    if(mode_pg)
    {
        BottomChange  += SetSimplePGMode(selected_adj, faixaDeOperacao);
        //definirAjusteNivelInferiorDaOrdem(SetSimplePGMode(selected_adj, faixaDeOperacao));
        aumentarNivelInferiorDaOrdem(SetSimplePGMode(selected_adj, faixaDeOperacao));
    }
    else
    {
        BottomChange  += selected_adj * faixaDeOperacao;
        //definirAjusteNivelInferiorDaOrdem(selected_adj * faixaDeOperacao);
        aumentarNivelInferiorDaOrdem(selected_adj * faixaDeOperacao);
    }
}


void calcularAjusteDeDistanciaDoLevelSuperior(double mode_pg, double selected_adj, double faixaDeOperacao)
{
    if(mode_pg)
    {
        TopChange  += SetSimplePGMode(selected_adj, faixaDeOperacao);
        //definirAjusteNivelSuperiorDaOrdem(SetSimplePGMode(selected_adj, faixaDeOperacao));
        aumentarNivelSuperiorDaOrdem(SetSimplePGMode(selected_adj, faixaDeOperacao));

    }
    else
    {
        TopChange  += selected_adj * faixaDeOperacao;
        //definirAjusteNivelSuperiorDaOrdem(selected_adj * faixaDeOperacao);
        aumentarNivelSuperiorDaOrdem(selected_adj * faixaDeOperacao);
    }
        //+------------------------------------------------------------------+
        // Temporário
        //+------------------------------------------------------------------+	
        // Módulo temporário para comparação de variáveis de reetruturação do código

        if(Level_Sell != nivelSuperiorDaOrdem){
            Print("Inconsistência no level superior - calcularAjusteDeDistanciaDoLevelSuperior!");
            Print("Level_Sell -> ", Level_Sell);
            Print("nivelSuperiorDaOrdem -> ", nivelSuperiorDaOrdem);

        }

        if(Level_Buy != nivelInferiorDaOrdem){

            Print("Inconsistência no level inferior - calcularAjusteDeDistanciaDoLevelSuperior!");
            Print("Level_Buy -> ", Level_Buy);
            Print("nivelInferiorDaOrdem -> ", nivelInferiorDaOrdem);

        }




}
void SetDistanceTopChange_evo(double mode_pg, double selected_adj, double start, double end)
{
    double faixaDeOperacao;
    if(end > start)
    {
        faixaDeOperacao = end - start;
    } 
    if(mode_pg)
    {
        //Print("mode_pg");
        TopChange  += SetSimplePGMode(selected_adj, faixaDeOperacao);
        //definirAjusteNivelSuperiorDaOrdem(SetSimplePGMode(selected_adj, faixaDeOperacao));
        aumentarNivelSuperiorDaOrdem(SetSimplePGMode(selected_adj, faixaDeOperacao));
    }
    else
    {
        //Print("mode_pa");
        TopChange  += selected_adj * faixaDeOperacao;
        //definirAjusteNivelSuperiorDaOrdem(selected_adj * faixaDeOperacao);
        aumentarNivelSuperiorDaOrdem(selected_adj * faixaDeOperacao);
    }
}



void EstENOrerDst_5010()
{

    EstENOrerDst_50();
    definirDistanciaDoLevel_cfg_10();

}


void EstENOrerDst_01()
{

    double sequenciaMaximaDeEntradasEstabelecida;
    double adj_end_vol;
    double ref_vol;
    definirSequenciaMaximaDeEntradasEstabelecida(sequenciaMaximaDeEntradasEstabelecida);
    SetAdjVolVolEnd(adj_end_vol);
    definirVolumeAtualEmLoteOuUnidade(ref_vol);


    if(ref_vol > ajusteDeDistanciaPorVolumeAPartirDe && ref_vol <= adj_end_vol)
    {
        if(pos_status == 0)
        {
            BottomChange = ajusteDeDistanciaPorVolume * (ref_vol - AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE);
            
            definirAjusteNivelInferiorDaOrdem(ajusteDeDistanciaPorVolume * (ref_vol - AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE));

            if(sequenciaDeEntradaNivelSuperior > AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE && sequenciaDeEntradaNivelSuperior <= sequenciaMaximaDeEntradasEstabelecida);
            {
                TopChange  += ajusteDeDistanciaPorSequencia * (sequenciaDeEntradaNivelSuperior - AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE);
                aumentarNivelSuperiorDaOrdem(ajusteDeDistanciaPorSequencia * (sequenciaDeEntradaNivelSuperior - AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE)); 
            }
        }
        if(pos_status == 1)
        {
            TopChange = ajusteDeDistanciaPorVolume * (ref_vol - AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE); 
            definirAjusteNivelSuperiorDaOrdem(ajusteDeDistanciaPorVolume * (ref_vol - AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE));
            if(sequenciaDeEntradaNivelInferior > AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE && sequenciaDeEntradaNivelInferior <= sequenciaMaximaDeEntradasEstabelecida);
            {
                BottomChange  += ajusteDeDistanciaPorSequencia * (sequenciaDeEntradaNivelInferior - AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE);
                aumentarNivelInferiorDaOrdem(ajusteDeDistanciaPorSequencia * (sequenciaDeEntradaNivelInferior - AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE));
            }            
        }
    }
}
void EstENOrerDst_02()
{
    /*
        Faz o mesmo que o 13 mas soma a sequência com o volume para o mesmo lado
    */

    //double sequenciaMaximaDeEntradasEstabelecida;
    double adj_end_vol;
    double ref_vol;
    //definirSequenciaMaximaDeEntradasEstabelecida(sequenciaMaximaDeEntradasEstabelecida);
    SetAdjVolVolEnd(adj_end_vol);
    definirVolumeAtualEmLoteOuUnidade(ref_vol);



    if(ref_vol > AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE && ref_vol <= adj_end_vol)
    {
        if(pos_status == 0)
        {
            BottomChange += ajusteDeDistanciaPorVolume * (ref_vol - AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE);   
        }
        if(pos_status == 1)
        {
            TopChange += ajusteDeDistanciaPorVolume * (ref_vol - AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE); 
        }
    }

    definirDistanciaDoLevel_cfg_10();
          

}
