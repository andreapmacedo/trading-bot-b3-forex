

void TP_OrderAnchor_Settings(int chosen)
{
    switch(chosen)
    {
        case 0: 
            break;
        case 10:  // Distância por sequencia
           // TP_STR_Anchor_10();
        case 101:  
            TP_STR_Anchor_101();
            break;
        case 201:  
            TP_STR_Anchor_201();
            break;

    }
}

void TP_STR_Anchor_101()
{
    Level_tp_long = PriceInfo[1].high;
    Level_tp_short = PriceInfo[1].low;    
}
void TP_STR_Anchor_201()
{
    Level_tp_long = PriceInfo[1].low;
    Level_tp_short = PriceInfo[1].high;    
}

//+------------------------------------------------------------------+
// Distância por sequência
//+------------------------------------------------------------------+

// void definirDistanciaDoLevel_cfg_10() 
// {
//     double adj_end_seq;
//     definirSequenciaMaximaDeEntradasEstabelecida(adj_end_seq);
    
//     if(sequenciaDeEntradaNivelInferior > AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE)
//     {
//         double range;
//         if(sequenciaDeEntradaNivelInferior <= adj_end_seq)
//         {
//             range = sequenciaDeEntradaNivelInferior-AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE;
//         }
//         else if(sequenciaDeEntradaNivelInferior > adj_end_seq)
//         {
//             range = adj_end_seq-AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE;
//         }

//         calcularAjusteDeDistanciaDoLevelInferior(AJUSTAR_DISTANCIA_POR_SEQUENCIA_MODO_PG, ajusteDeDistanciaPorSequencia, range);
//     }
//     else if(sequenciaDeEntradaNivelSuperior > AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE)   
//     {
//         double range;
//         if( sequenciaDeEntradaNivelSuperior <= adj_end_seq)
//         {
//             range = sequenciaDeEntradaNivelSuperior-AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE;
//         }
//         else if(sequenciaDeEntradaNivelSuperior > adj_end_seq)
//         {
//             range = adj_end_seq-AJUSTE_DE_DISTANCIA_POR_SEQUENCIA_A_PARTIR_DE;
//         }
//         calcularAjusteDeDistanciaDoLevelSuperior(AJUSTAR_DISTANCIA_POR_SEQUENCIA_MODO_PG, ajusteDeDistanciaPorSequencia, range);
//     }
// }